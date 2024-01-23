# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  product_id :integer
#  quantity   :integer
#  unit_price :integer
#  total      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_purchases_on_client_id   (client_id)
#  index_purchases_on_product_id  (product_id)
#

class Purchase < ActiveRecord::Base
  # Constants
  # Enums
  # Associations (belongs_to, has_one, has_many, has_and_belongs_to_many)
  # Extensions (includes Rails concerns)
  # Scopes
  # Validations
  # Callbacks (before_save, after_commit, etc.)
  # Delegations
  # Virtual attributes (attr_accessor, etc.)
  # Class methods (self.method)
  # Instance methods
  # Private methods
  include ::CreatedBy
  attr_accessible :client_id, :product_id, :product, :client, :quantity, :unit_price, :total

  belongs_to :client
  belongs_to :product


  validates :product, :client, :quantity, :unit_price, :total, presence: true
end
