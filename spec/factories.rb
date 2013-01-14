Factory.define :role do |role|  
  #role.id 4
  role.name "Admin"  
end
Factory.define :user do |user| 
  user.username "Example"
  user.full_name "Example"
  user.email "example@dai.co.uk"
  user.password "Example"
  user.password_confirmation "Example"
end

Factory.define :user_normal, :class => User do |user|
  user.username "Example1"
  user.full_name "Example1"
  user.email "example1@dai.co.uk"
  user.password "Example1"
  user.password_confirmation "Example1"
end 


Factory.define :roles_user do |ru|
  
  ru.association(:role)
  ru.interested { |i| i.association(:user)}
end

Factory.define :admin_as_a_role, :class => 'RolesUser' do |this|
  this.role { |role| role.association(:role, :name => "Admin") }
end

Factory.define :user_admin, :parent => :user do |user|
  user.after_create { |u| Factory(:admin_as_a_role, :interested => u) }
end


Factory.define :project_task do |p|
  p.project_id "1"
  p.task_name "Example"
end

Factory.define :company do |company|
  company.name "Example"
  company.address "123 Shark Road, London, England, SW1 9EP"
  company.telephone "02082860642"
  company.email "example@dai.co.uk"
end

Factory.define :contact do |contact| 
  contact.name "Example"
  contact.position "Position"
  contact.telephone "02082860634" 
  contact.email "example@dai.co.uk"
  contact.source "www.example.co.uk"
  contact.company_id "dai"
end

#Factory.define :project do |project|
#
#  project.number "12EX"
#  project.name "ExampleName"
#  project.manager_user_id "ExampleDude"
#end 
