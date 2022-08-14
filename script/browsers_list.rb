# frozen_string_literal: true

module BrowsersList
  # List of browsers available
  # Make sure the browser name matches the drivers
  # Docs here: https://www.selenium.dev/documentation/webdriver/getting_started/install_drivers/
  # I was not able to to test Safari since I have a linux computer, but should work the same
  BROWSERS = {
    "chrome" => "#{Dir.pwd}/drivers/chromedriver",
    "firefox" => "#{Dir.pwd}/drivers/geckodriver",
    "edge" => "#{Dir.pwd}/drivers/msedgedriver"
  }

  DEFAULT_BROWSERS = BROWSERS.keys[0]
end
