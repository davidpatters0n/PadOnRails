require 'spec_helper'

describe "ProjectTasks" do
            describe "GET 'index' in project_tasks;" do
                      it "works! (now write some real specs)" do
                        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
                        get project_tasks_index_path
                        response.status.should be(200)
                      end
                      
                      it "should be successfull" do
                        get project_tasks_index_path
                        response.should be_success
                      end
                      
                      it "should have the right title" do
                        get project_tasks_index_path
                        response.should have_selector("title", :content => "Listing Project Tasks")
                      end
                      
                      it "should display tasks" do
                        ProjectTask.create!(:task_name => "project")
                        visit project_tasks_index_path
                        response.should contain('project')
                      end  
                      
            end


            describe "GET 'new' in project_tasks;" do
              
                  it "should be successfull" do
                get project_tasks_new_path
                response.should be_success
              end
              
                  it "should have the right title" do
                get project_tasks_new_path
                response.should have_selector("title", :content => "New Project Task")
              end
           
            end
            

            
            
end