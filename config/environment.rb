# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SmartCongratulationsReminder::Application.initialize!
Time::DATE_FORMATS[:birth_date] = "%d.%m.%Y"