class Comment < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  mount_uploader :file, FileUploader
  belongs_to :contact
  belongs_to :company
  
end


# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  commenter  :string(255)
#  body       :text
#  contact_id :integer(4)
#  company_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  file       :string(255)
#

