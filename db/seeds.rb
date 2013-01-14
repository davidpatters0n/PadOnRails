require 'faker'

Role.create!(:name => "Developer")
Role.create!(:name => "Corporate")
Role.create!(:name => "ProjectManager")
Role.create!(:name => "Admin")
Role.create!(:name => "TeamLeader")
Role.create!(:name => "Engineer")
Role.create!(:name => "BusinessManager")

# Standard users              
User.create!( :username => "BACKDOOR", 
              :full_name => "Backdoor account",
              :email => "dummy@dai.co.uk",
              :password => "Clyde_01",
              :password_confirmation => "Clyde_01",
              :role_ids => [1, 2, 3, 4, 5, 6])
              
User.create!( :username => "ahmet",
              :full_name => "ahmet",
              :email => "ahmet.abdi@dai.co.uk",
              :password => "ahmet123",
              :password_confirmation => "ahmet123",
              :role_ids => [1, 2, 3, 4, 5, 6])

User.create!( :username => "developer",
              :full_name => "developer",
              :email => "developer@dai.co.uk",
              :password => "developer",
              :password_confirmation => "developer",
              :role_ids => [1])
                            
User.create!( :username => "corporate",
              :full_name => "corporate",
              :email => "corporate@dai.co.uk",
              :password => "corporate",
              :password_confirmation => "corporate",
              :role_ids => [2])
              
User.create!( :username => "manager",
              :full_name => "manager",
              :email => "manager@dai.co.uk",
              :password => "manager",
              :password_confirmation => "manager",
              :role_ids => [3])
              
User.create!( :username => "admin",
              :full_name => "admin",
              :email => "admin@dai.co.uk",
              :password => "google",
              :password_confirmation => "google",
              :role_ids => [1, 2, 3, 4, 5, 6, 7])    

User.create!( :username => "leader",
              :full_name => "leader",
              :email => "leader@dai.co.uk",
              :password => "leader",
              :password_confirmation => "leader",
              :role_ids => [5])  
              
User.create!( :username => "engineer",
              :full_name => "engineer",
              :email => "engineer@dai.co.uk",
              :password => "engineer",
              :password_confirmation => "engineer",
              :role_ids => [6])   

# Create the admin project and the special admin tasks
# 'Manager' of the project is the backdoor user
Project.create!( :project_number => "A001",
                 :project_name => "ADMIN",
                 :manager_user_id => 1,
                 :account_manager => 2 )
                 
ProjectTask.create!( :project_id => "1",:taskType => "ADMIN", :task_name => "Leave" )
ProjectTask.create!( :project_id => "1",:taskType => "ADMIN", :task_name => "Toil" )
ProjectTask.create!( :project_id => "1",:taskType => "ADMIN", :task_name => "Sick" )

def createStdTasks(project_id)
  ProjectTask.create!( :project_id => project_id,:taskType => "Pre-Sales", :task_name => "Pre-Sales" ) 
  ProjectTask.create!( :project_id => project_id,:taskType => "Project", :task_name => "Project" ) 
  ProjectTask.create!( :project_id => project_id,:taskType => "Fault Fixing", :task_name => "Fault Fixing" ) 
  ProjectTask.create!( :project_id => project_id,:taskType => "Support", :task_name => "Support" ) 
  ProjectTask.create!( :project_id => project_id,:taskType => "Out Of Hours", :task_name => "Out Of Hours" ) 
end

Project.create!( :project_number => "S006T",
                 :project_name => "PadOnRails",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "2" )

Project.create!( :project_number => "DM9917",
                 :project_name => "BMW",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "3" )

Project.create!( :project_number => "DM0131",
                 :project_name => "Asda",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "4" )

Project.create!( :project_number => "DM0969",
                 :project_name => "Chain Reaction Cycles",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "5" )

Project.create!( :project_number => "DM0879",
                 :project_name => "JD Sports",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "6" )

Project.create!( :project_number => "DM0814",
                 :project_name => "Dairy Crest Manual WMS",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "7" )

Project.create!( :project_number => "DM0643",
                 :project_name => "Tesco Sun & Moon",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "8" )

Project.create!( :project_number => "DM0871",
                 :project_name => "Netto",
                 :manager_user_id => 5,
                 :account_manager => 5)
createStdTasks( "9" )
      
                
50.times do |n|
      name =  Faker::Company.name
      email = Faker::Internet.email
      telephone = Faker::PhoneNumber.phone_number
      address = Faker::Address.street_address(include_secondary = false) + ", " + Faker::Address.uk_county + ", " + Faker::Address.uk_country + ", " + Faker::Address.uk_postcode + "." 

      company = Company.create!(:name => name,
                      :address => address,
                      :telephone => telephone,
                      :email => email)
                   
      name = Faker::Name.name
      email = Faker::Internet.email
      telephone = Faker::PhoneNumber.phone_number

      Contact.create!(:name => name,
                      :position => "Position",
                      :email => email,
                      :telephone => telephone,
                      :source => "Source",
                      :company => company)
end

Company.create!(:name => "Asda Roehampton", :address => "RoeHampton Vale, SW15", :telephone => "42083458345", :email => "asdaroehampton@asda.co.uk")

99.times do |n|
      username = Faker::Internet.user_name 
      until User.find_by_username( username ) === nil
        username = Faker::Internet.user_name 
      end
      
      email = Faker::Internet.email
      until User.find_by_email( email ) === nil
        email = Faker::Internet.email
      end
      
      fullname = Faker::Name.name
      password  = "password"
      roles = [(6 > 1) ? 1 + rand((6-1+1)) : 6 + rand((1-6+1))]
      User.create!(:username => username,
                   :full_name => fullname,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :role_ids => roles)
                   
end
