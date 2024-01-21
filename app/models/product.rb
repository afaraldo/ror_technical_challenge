# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base
  include ::CreatedBy
  attr_accessible :name
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :images

end
