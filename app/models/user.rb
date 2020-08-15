class User < ApplicationRecord
  has_many :articles, dependent: :destroy 
  has_secure_password
  mount_uploader :image, ImageUploader

  validates :username, presence: true,
    length: { minimum: 2, maximum: 10, allow_bank: true },
    uniqueness: { case_sensitive: false } 
  validates :email, presence: true, "valid_email_2/email": true,
  uniqueness: { case_sensitive: false } 
  
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, on: :create
  
  attr_accessor :current_password
  
  def active?
    !suspended? 
  end
end
