# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hidb::Application.initialize!

require 'hirb'
Hirb::View.enable