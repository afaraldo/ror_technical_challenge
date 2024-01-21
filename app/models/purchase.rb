# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_purchases_on_client_id   (client_id)
#  index_purchases_on_product_id  (product_id)
#

class Purchase < ActiveRecord::Base
  include ::CreatedBy
  attr_accessible :client_id, :product_id, :product, :client

  belongs_to :client
  belongs_to :product
end
