require 'spec_helper'


describe Comment do

  it "should relate to comapny" do
    Comment.reflect_on_association(:company).should be_true
  end

it "should relate to contact" do
    Comment.reflect_on_association(:contact).should be_true
  end

end

``

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

