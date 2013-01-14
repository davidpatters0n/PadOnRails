class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :roles_users
  has_many :roles, :through => :roles_users
  has_many :projects, :foreign_key => "manager_user_id"
  has_many :password_histories
  has_many :efforts
  has_many :users_projects
  has_many :effort_projects, :through => :users_projects, :source => :project

  after_save :store_digest
  
  # authorization include this in whichever model that will use ACL9
  acts_as_authorization_subject :user => 'User'
  #acts_as_authorization_subject
  def has_role?(role_name, object=nil)
    !! if object.nil?
      self.roles.find_by_name(role_name.to_s) ||
      self.roles.member?(get_role(role_name, nil))
    else
      method = "is_#{role_name.to_s}?".to_sym
    object.respond_to?(method) && object.send(method, self)
    end
  end

  def login(user)
    post_via_redirect user_session_path, 'user[username]' => user.username, 'user[password]' => user.password
  end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable #:registerable,
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  acts_as_authorization_subject  :association_name => :roles
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :login, :username, :full_name, :email, :password, :password_confirmation, :remember_me, :role_ids

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :username, :email, :full_name, :password, :password_confirmation
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_length_of :password, :minimum => 6, :allow_blank => true
  validates_confirmation_of :password
  validates_uniqueness_of :username, :email
  validates :email, :presence => true,
                    :format   => { :with => email_regex, :message => "Email should be like example@example.com" }
  validates :password, :unique_password => true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end

  private

  def store_digest
    if encrypted_password_changed?
      PasswordHistory.create(:user_id => self, :encrypted_password => encrypted_password)
    end
  end

end


# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer(4)      default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  full_name              :string(255)
