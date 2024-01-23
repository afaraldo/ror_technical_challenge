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

require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
