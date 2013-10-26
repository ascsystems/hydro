class Promotion < ActiveRecord::Base

  attr_accessible :promo_code, :start_date, :end_date, :amount, :type

  def getPromo(promo)
  	self.where("promo_code = ? and today >= from_date AND today <= to_date", promo).first
  end

end