# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Image < ActiveRecord::Base
  include ::CreatedBy
  has_attached_file :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/
end
