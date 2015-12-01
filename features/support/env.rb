require 'capybara'
require 'capybara/cucumber'
require 'selenium/webdriver'

# Create the base url for the site
BASE_URL = 'http://www.which.co.uk'

# Return environment variable for default browser. Chrome is default if ENV variable is not set
def browser
  (ENV['BROWSER'] ||= 'chrome').to_sym
end

# Register driver
Capybara.register_driver browser do |app|
  Capybara::Selenium::Driver.new app, :browser => browser
end

Capybara.default_driver = browser

# Set timeouts to 5 seconds to be sure that AJAX requests goes through with the loader
Capybara.default_max_wait_time = 5
