class Account < ActiveRecord::Base
  
  has_many :orders
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  # Cannot create 2 different accounts with the same email
  validates_uniqueness_of :email, :case_sensitive => false
  
end
