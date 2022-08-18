require 'selenium-webdriver'
require 'rspec'
require 'rest-client'
require 'cucumber'
require 'rake'

def initialize_wd_session(brs_hash = {})
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 600
  @browser = Selenium::WebDriver.for(brs_hash['browser'], driver_path: brs_hash['path'], http_client: client)
  @browser.manage.window.resize_to(brs_hash['window_x'], brs_hash['window_y'])
  @browser.manage.timeouts.page_load = 120
end
