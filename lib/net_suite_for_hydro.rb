# FIXME work in progress

# Call with:   NetSuiteForHydro::HydroHelper.<method>
module NetSuiteForHydro
  
  class HydroHelper
    
    def self.test_items
      
      #FIXME - Gives:  NameError: uninitialized constant NetSuite::Records::BaseRefList
      item = NetSuite::Records::BaseRefList.get_select_value(
        field: 'class',
        recordType: 'salesOrder',
        sublist: 'itemList'
      )
      item
    end
    
    def self.get_customer_test
      # If not found, it returns exception: NetSuite::RecordNotFound
      NetSuite::Records::Customer.get(:internal_id => 4)
      
      #NetSuite::Records::Contact.get(:internal_id => 4)
    end
    
    # Contact:
    #actions :get, :add, :delete, :search
    #
    #fields :salutation, :first_name, :middle_name, :last_name, :title, :phone, :fax, :email, :default_address,
    #         :entity_id, :phonetic_name, :alt_email, :office_phone, :home_phone, :mobile_phone, :supervisor_phone,
    #         :assistant_phone, :comments, :bill_pay, :is_private, :is_inactive
    def self.create_contact_test
      contact = NetSuite::Records::Contact.new(first_name: 'Homer', last_name: 'Simpson', email: 'homers@testing.com')  #, phone: '403-456-7890')
      
      # FIXME: I'm getting "false" for this! why?!
      contact.add
      #contact
    end
    
    def self.find_a_customer_test
      search = NetSuite::Records::Customer.search({
        basic: [
          {
            field: 'email',
            operator: 'is',
            value: 'david@ascsystems.com'
          }
        ]
      })
      
      search.results.inspect
    end
    
    def self.find_a_contact
      search = NetSuite::Records::Contact.search({
        basic: [
          {
            field: 'email',
            operator: 'contains',
            value: 'david@ascsystems.com'
          }
        ]
      })
      
      #search.results.inspect if search.present?
    end
    
    
  end
end

# Example PHP code found by googling
=begin
$orderSearch = new nsComplexObject(‘TransactionSearchBasic’);

$typeSearchField = new nsComplexObject(‘SearchEnumMultiSelectField’);
$typeSearchField->setFields(array(‘searchValue’ => array(‘_salesOrder’),
‘operator’ => ‘anyOf’));

$orderSearch->setFields(array(
“nameText” => array(
“operator” => “is”,
“searchValue” => $this->customerName
),
“type”=>$typeSearchField
));

#-------------------------------------------------------

$customerSearch = new nsComplexObject('CustomerSearchBasic');
$customerSearch->setFields(array(
    "email" => array(
        "operator" => "is",
        "searchValue" => $email
    )
));
$myNSclient->setSearchPreferences(false, 1000);
try {
    $response = $myNSclient->search($customerSearch);
}catch(Exception $e){
    //do something
}
/* @var $response nsSearchResponse */
if ($response->isSuccess == true) {
    $totalRecords = (int) $response->totalRecords;
    if ($totalRecords == 0) {
        //nothing was found
    }
    $recordList = $response->recordList;
    if ($totalRecords == 1) {
        $record = $recordList[0];
        //$record is a nsComplexObject of type customer
    } else if ($totalRecords > 1) {
        foreach ($recordList as $record) {
            //$record is a nsComplexObject of type customer
        }
    }
}else{
    print_r($response);//something went wrong, see the error message
}


=end


# example from: http://www.ozonesolutions.com/programming/2011/12/netsuite-create-customercontact/
=begin
//This script assumes you have logged into Netsuite with your credentials to create $myNSclient
//Remeber to do validation on your data before submiting
$customerSetFieldsArray;
$contactRef = null;
$customerRef = null;
$entityStatus = new nsComplexObject("RecordRef");
$entityStatus->setFields(array("internalId" => 7));
$listOrRecordRef = new nsComplexObject('ListOrRecordRef');
$listOrRecordRef->setFields(array('internalId' => 25, 'typeId' => 1));
$selectCustFieldRef = new nsComplexObject("SelectCustomFieldRef");
$selectCustFieldRef->setFields(array("internalId" => 'custentity24', 'value' => $listOrRecordRef));
$customFieldList = new nsComplexObject("CustomFieldList");
$customFieldList->setFields(array("customField" => array($selectCustFieldRef)));
if($isPerson == "true") {
    $customerSetFieldsArray = array(
            "isPerson" => true,
            "firstName" => $fName,
            "lastName" => $lName,
            "email" => $email,
            "entityStatus" => $entityStatus,
            "customFieldList" => $customFieldList
    );
}
else {
    $customerSetFieldsArray = array(
            "isPerson" => false,
            "companyName" => $companyName,
            "entityStatus" => $entityStatus,
            "email" => $email,
            "customFieldList" => $customFieldList
    );
    $contactFieldArray = array(
            "firstName" => $fName,
            "lastName" => $lName,
            "email" => $email
    );
    $contact = new nsComplexObject("Contact");
    $contact->setFields($contactFieldArray);
}
$customer = new nsComplexObject("Customer");
$customer->setFields($customerSetFieldsArray);
try {
    if($save) {
        $writeResponse = $myNSclient->add($customer);
    }
    if($writeResponse->isSuccess != '1') {
        $line = __LINE__;
        $fields = &$customer->nsComplexObject_fields;
        $error[] = "Failed to create customer on line $line, trying again with timestamp on name";//Netsuite doesn't allow duplicate names so add the timestamp to the name
        if($isPerson == "true") {
            $customerSetFieldsArray = array(
                    "isPerson" => true,
                    "firstName" => $fName,
                    "lastName" => $lName,
                    "email" => $email,
                    "entityStatus" => $entityStatus,
                    "customFieldList" => $customFieldList
            );
            $lName .= "(" . time() . ")";
            $fields['lastName'] = $lName;
        }
        else {
            $companyName .= "(" . time() . ")";
            $customerSetFieldsArray = array(
                    "isPerson" => false,
                    "companyName" => $companyName,
                    "entityStatus" => $entityStatus,
                    "email" => $email,
                    "customFieldList" => $customFieldList
            );
            $fields['companyName'] = $companyName;
        }
        if($save) {
            $writeResponse = $myNSclient->add($customer);
        }
        if($writeResponse->isSuccess != '1') {
            $line = __LINE__;
            $error[] = "Completely failed to create customer on line $line";
        }
    }
    $customerRef = $writeResponse->recordRef;
    $companyNsID = $customerRef->getField('internalId');
} catch(Exception $e) {
    $line = __LINE__;
    $error[] = "Completely failed to create customer on line $line";
}
if($isPerson == "false") {
    try {
        $contactFieldArray['company'] = $customerRef;
        $contact->setFields($contactFieldArray);
        if($save) {
            $writeResponse = $myNSclient->add($contact);
        }
        if($writeResponse->isSuccess != '1') {//retry submit
            $line = __LINE__;
            $error[] = "Failed to create contact on line $line, trying again with timestamp on name";
            $lName .= "(" . time() . ")";
            $contactFieldArray['lastName'] = $lName;
            $contact->setFields($contactFieldArray);
            if($save)
                $writeResponse = $myNSclient->add($contact);
            if($writeResponse->isSuccess != '1') {
                $line = __LINE__;
                $error[] = "Completely failed to create contact on line $line";
            }
        }
        $contactRef = $writeResponse->recordRef;
    }
    catch(Exception $e) {
        $line = __LINE__;
        $error[] = "Completely failed to create contact on line $line";
    }
}
if($contactRef != null && $customerRef != null) {
    $attachRef = new nsComplexObject('AttachContactReference');
    $attachRef->setFields(array('attachTo' => $customerRef, 'contact' => $contactRef));
    if($save) {
        $writeResponse = $myNSclient->attach($attachRef);
    }
    if($writeResponse->isSuccess != '1') {
        $line = __LINE__;
        $error[] = "Failed to link contact with customer on line $line";
    }
}
=end