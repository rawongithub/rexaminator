# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rexaminator::Application.initialize!

# Define global application constants
MAX_SESSION_PERIOD = 60.minutes
MAX_SESSION_LIMIT  = 2.days

