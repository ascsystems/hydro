class Promotion < ActiveRecord::Base

  attr_accessible :promo_code, :start_date, :end_date, :amount, :promo_type

  def getPromo(promo)
  	this_promo = Promotion.where("promo_code = ? and CURDATE() between start_date AND end_date", promo).first
  	return this_promo
  end

end