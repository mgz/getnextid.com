require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium/webdriver'

Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  # config.before(:each, type: :system) do
  #   driven_by(:rack_test)
  # end
  config.before(:each, type: :system, headless: false) do
    driven_by(:selenium_chrome)
  end
  config.before(:each, type: :system, headless: true) do
    driven_by(:selenium_chrome_headless)
  end
end


Capybara::Screenshot.prune_strategy = :keep_last_run

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end