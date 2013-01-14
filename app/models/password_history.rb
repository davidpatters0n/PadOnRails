class PasswordHistory < ActiveRecord::Base
   
end


# == Schema Information
#
# Table name: password_histories
#
#  id                 :integer(4)      not null, primary key
#  user_id            :integer(4)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

