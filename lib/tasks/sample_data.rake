namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Rake::Task['db:seed'].invoke
    User.create!(:username => "Example",
                 :full_name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar",
                 :role_ids => [(6 > 1) ? 1 + rand((6-1+1)) : 6 + rand((1-6+1))])
    99.times do |n|
      username  = Faker::Internet.user_name
      fullname = Faker::Name.name
      email = Faker::Internet.email
      password  = "password"
      roles = [(6 > 1) ? 1 + rand((6-1+1)) : 6 + rand((1-6+1))]
      User.create!(:username => username,
                   :full_name => fullname,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :role_ids => roles)
    end
  end
end