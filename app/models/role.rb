class Role < ActiveRecord::Base
  has_many :roles_users
  has_many :users, :through => :roles_users
    acts_as_authorization_role
    
    attr_accessible :id, :name
end 

# == Schema Information
#
# Table name: roles
#
#  id                :integer(4)      not null, primary key
#  name              :string(40)
#  authorizable_type :string(40)
#  authorizable_id   :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#

