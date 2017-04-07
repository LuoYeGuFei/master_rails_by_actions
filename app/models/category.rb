class Category < ApplicationRecord

  validates_presence_of :title, message: "名称不能为空"
  validates_uniqueness_of :title, message: "名称不能重复"

  has_ancestry orphan_strategy: :destroy
  has_many :products, dependent: :destroy

  before_validation :correct_ancestry

  def self.grouped_data
    self.roots.order('weight desc').inject([]) do |result, parent|
      row = []
      row << parent
      row << parent.children.order('weight desc')
      result << row
    end
  end

  private
  def correct_ancestry
    self.ancestry = nil if ancestry.blank?
  end
end
