class ShoppingCart < ApplicationRecord

  validates_presence_of :user_uuid, :product_id, :amount

  belongs_to :product

  scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

  def self.create_or_update! options = {}
    attrs = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }

    record = where(attrs).first

    if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
    else
      record = create!(options)
    end

    record
  end

end
