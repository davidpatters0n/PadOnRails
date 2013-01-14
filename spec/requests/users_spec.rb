require 'spec_helper'

describe "Users" do
    describe "Login" do
        it "should let a user log in" do       
            visit user_session_path
            fill_in "Login", :with => "admin"
            fill_in "Password", :with => "google"
            click_button
            response.should be_success
            response.should render_template(root_path)
        end      
        it "should not let a user log in" do
            visit user_session_path
            fill_in "Login", :with => ""
            fill_in "Password", :with => ""
            click_button
            response.should be_success
            response.should render_template('devise/sessions/new')             
        end
        it "should not let a user log in with false information" do
            visit user_session_path
            fill_in "Login", :with => "admin"
            fill_in "Password", :with => "hacku"
            click_button
            response.should be_success
            response.should render_template('devise/sessions/new')  
        end
     end 
end