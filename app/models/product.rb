# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ActiveRecord::Base
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
  attr_accessible :name, :price

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :images
  belongs_to :user
  has_many :purchases

  validates :name, :price, presence: true

end
