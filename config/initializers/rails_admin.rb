# This code was taken from the rails_admin.rb.example file.  You can look at it for more config examples
# that were generated based on the existing database tables and models at the time.

#------ START my notes -----------------------------------------------------
# http://rubydoc.info/github/sferik/rails_admin/master/file/README.md
# http://rubydoc.info/github/sferik/rails_admin/master/

#https://github.com/sferik/rails_admin/wiki/Troubleshoot

# For an example of using IMPORT:
# http://blog.endpoint.com/2012/02/railsadmin-import-part-2.html

# Good example of some customization:
# http://blog.endpoint.com/2011/08/railsadmin-gem-ecommerce.html

# Since rails_admin uses twitter bootstrap theme, it has these same SASS variables --
# change them, and the theming elements will change 
# (Or if you're using twitter bootstrap in your main theme, change these vars to customize it)
#http://twitter.github.com/bootstrap/less.html#variables
#------- END my notes --------------------------------------------------------

# RailsAdmin config file. Generated on September 06, 2013 13:54
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Hydro Flask', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_account } # auto-generated

  # If you want to track changes on your models:
  config.audit_with :history, 'Account'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'Account'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  config.default_items_per_page = 50

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Account', 'Ambassador', 'Brand', 'Cart', 'CartRelatedProduct', 'Category', 'CategoryProduct', 'Charity', 'Donation', 'EmailSubscription', 'LineItem', 'LineItemOption', 'MailingList', 'Option', 'OptionType', 'OptionValue', 'Order', 'Page', 'Product', 'ProductImage', 'ProductOptionValue', 'ProductOptionValueImage', 'ProductType', 'RelatedProduct', 'Review', 'Shipping', 'StateTaxRate', 'Store']

  # Include specific models (exclude the others):
  # config.included_models = ['Account', 'Ambassador', 'Brand', 'Cart', 'CartRelatedProduct', 'Category', 'CategoryProduct', 'Charity', 'Donation', 'EmailSubscription', 'LineItem', 'LineItemOption', 'MailingList', 'Option', 'OptionType', 'OptionValue', 'Order', 'Page', 'Product', 'ProductImage', 'ProductOptionValue', 'ProductOptionValueImage', 'ProductType', 'RelatedProduct', 'Review', 'Shipping', 'StateTaxRate', 'Store']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]
  
  #--------------------------
  # manual role validation here (if we use CanCan for roles, then replace this)
  # note: Account is our auth model, so devise generates convenience method "current_account",
  #       which returns the logged-in account
  config.authorize_with do |controller|
    
    if (current_account && !(current_account.is_cms_admin?))
      flash[:notice] = "You are not an authorized admin user."
      redirect_to main_app.root_path
    end
  end
  #---------------------------



  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:
  # ... SEE rails_admin.rb.example ...
  
  # Use ckeditor WSIWYG editor interface for all "text" db fields
  #config.models do
  #  fields_of_type :text do
  #    ckeditor true
  #  end 
  #end
  
  # See here for rails_admin ckeditor instructions, including connecting image uploader:
  # https://github.com/sferik/rails_admin/wiki/CKEditor
  # https://github.com/galetahub/ckeditor
  config.model Page do
    include_all_fields
    field :body, :text do
     ckeditor true
    end
    field :header_content, :text do
     ckeditor true
    end
    field :right_content, :text do
     ckeditor true
    end 
  end

end