class Category < ApplicationRecord

  validates_presence_of :title, message: "名称不能为空"

  has_ancestry
  has_many :products, dependent: :destroy

  before_validation :correct_ancestry

  private
  def correct_ancestry
    self.ancestry = nil if ancestry.blank?
  end
end
