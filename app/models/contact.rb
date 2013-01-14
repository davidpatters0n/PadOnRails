class Contact < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :company
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  telephone_regex = /[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/
  
  validates_presence_of :name, :position, :telephone, :email, :source, :company_id
 

  #validates :telephone, :presence => true, 
   #                     :format => { :with => telephone_regex, :message => 'Telephone must be 11 digits' }


  validates :email, :presence => true,
                    :format   => { :with => email_regex,:message => 'Enter valid email example@example.com ' }
end


# == Schema Information
#
# Table name: contacts
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  position   :string(255)
#  email      :string(255)
#  telephone  :string(255)
#  source     :string(255)
#  company_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

