# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PadOnRails::Application.initialize!

#config.gem "rmagick", :lib => "RMagick"

# Turn off auto TLS for e-mail
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
 