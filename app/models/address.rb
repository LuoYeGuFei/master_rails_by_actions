class Address < ApplicationRecord

  attr_accessor :set_as_default

  validates_presence_of :user_id, :address_type
  validates_presence_of :contact_name, message: "收货人不能为空"
  validates_presence_of :cellphone, message: "手机号不能为空"
  validates_presence_of :address, message: "地址不能为空"

  belongs_to :user

  before_save :set_as_default_address
  before_destroy :remove_self_as_default_address

  module AddressType
    User = 'user'
    Order = 'order'
  end

  private
  def set_as_default_address
    if self.set_as_default.to_i == 1
      self.user.default_address = self
      self.user.save!
    else
      remove_self_as_default_address
    end
  end

  def remove_self_as_default_address
    if self.user.default_address == self
      self.user.default_address = nil
      self.user.save!
    end
  end
end
