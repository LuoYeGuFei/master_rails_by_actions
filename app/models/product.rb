class Product < ApplicationRecord

  validates_presence_of :category_id, message: "分类不能为空"
  validates_presence_of :title, message: "名称不能为空"
  validates :status, inclusion: { in: %w[on off], 
    message: "商品状态必须为on | off"}
  validates :amount, numericality: { only_integer: true, 
    message: "库存必须为整数" },
    if: proc { |product| !product.amount.blank? }
  validates_presence_of :msrp, message: "MSRP不能为空"
  validates :msrp, numericality: { message: "MSRP必须为数字" },
    if: proc { |product| !product.msrp.blank? }
  validates_presence_of :price, message: "价格不能为空"
  validates :price, numericality: { message: "价格必须为数字" },
    if: proc { |product|!product.price.blank? }
  validates_presence_of :description, message: "描述不能为空"

  belongs_to :category

  before_create :set_default_attrs

  module Status
    On = 'on'
    Off = 'off'
  end

  private
  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end
end
