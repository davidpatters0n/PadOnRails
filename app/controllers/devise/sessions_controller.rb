class Devise::SessionsController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  include Devise::Controllers::InternalHelpers
  
  access_control do
      allow all
  end

  # GET /resource/sign_in
  def new
    @title = ""
    resource = build_resource
    clean_up_passwords(resource)
    respond_with_navigational(resource, stub_options(resource)){ render_with_scope :new }
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:success, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    if current_user.has_role? :Admin
      redirect_to dashboard_path
    elsif current_user.has_role? :ProjectManager
      redirect_to dashboard_path
    else
      redirect_to timesheet_path + "/" + current_user.id.to_s
    end
  end

  # GET /resource/sign_out
  def destroy
    signed_in = signed_in?(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :success, :signed_out if signed_in
    

    # We actually need to hardcode this, as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to login_path }
      format.all do
        method = "to_#{request_format}"
        text = {}.respond_to?(method) ? {}.send(method) : ""
        render :text => text, :status => :ok
      end
    end
  end

  protected

  def stub_options(resource)
    array = resource_class.authentication_keys.dup
    array << :password if resource.respond_to?(:password)
    { :methods => array, :only => [:password] }
  end
end