class Company < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :opportunities, :dependent => :destroy

  accepts_nested_attributes_for :contacts, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :address, :email, :telephone
  validates :email, :presence => true,
                    :format   => { :with => email_regex,:message => 'Enter valid email example@example.com ' }
end

#:telephone,


# == Schema Information
#
# Table name: companies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  telephone  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

