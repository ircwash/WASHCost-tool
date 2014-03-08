# Load the rails application
require File.expand_path('../application', __FILE__)

require 'ntlm/smtp'

# App Version
# As suggested at: http://blog.danielpietzsch.com/post/1209091430/show-the-version-number-of-your-rails-app-using-git
SHOW_APP_VERSION = true
APP_VERSION = `git describe --always` unless defined? APP_VERSION

# Initialize the rails application
WashCostApp::Application.initialize!

