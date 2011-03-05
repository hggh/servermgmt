
# Load the rails application
require File.expand_path('../application', __FILE__)

require 'lib/activerecord_base_create_update'
require 'lib/server_manager'

# Initialize the rails application
Servermgmt::Application.initialize!
