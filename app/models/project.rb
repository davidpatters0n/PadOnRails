class Project < ActiveRecord::Base
  belongs_to :user, :foreign_key => "manager_user_id"
  belongs_to :account_user, :class_name => "User", :foreign_key => "account_manager"
  has_many :project_tasks, :dependent => :destroy
  has_many :efforts, :through => :project_tasks

  accepts_nested_attributes_for :project_tasks, :reject_if => lambda { |a| a[:task_name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :account_user
  
  validates_presence_of :project_number, :project_name, :manager_user_id
  # No idea why this is not working ...
  # validates_associated :user, :message => "manager user is invalid"
  validates_format_of :project_number, :with => /^[a-zA-Z0-9_]/, :message => "should only contain letters and numbers"
  validates_length_of :project_number, :minimum => 4

#def project_name
#has_one_letter = project_name =~ /[a-zA-Z]/
#all_valid_characters = project_name =~ /^[a-zA-Z0-9_]+$/
#errors.add(:project_name, "must have at least one letter and contain only letters, digits, or underscores") unless (has_one_letter and all_valid_characters)

end



# == Schema Information
#
# Table name: projects
#
#  id              :integer(4)      not null, primary key
#  project_number  :string(255)
#  project_name    :string(255)
#  manager_user_id :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  account_manager :string(255)
#

