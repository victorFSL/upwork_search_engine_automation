# frozen_string_literal: true

require 'selenium-webdriver'
# To include all files under search_engines_selectors
Dir[File.join(__dir__,'search_engines_selectors','*')].each { |file| require file }
require_relative '../script/browsers_list'
require_relative '../script/search_engines'
require_relative '../utils/utils'

# This runs the selenium automation script steps
class Automation
  include BrowsersList
  include SearchEngines

  def initialize(browser:, search_engine:, search_term: )
    @browser = browser
    @search_engine = search_engine
    @search_term = search_term
    select_driver_binary
    open_browser
    instantiate_search_engine_class
    navigate_to_url
    retrieve_top_10_results
    save_results_to_file
  end

  def select_driver_binary
    @service = Selenium::WebDriver::Service.__send__(@browser, path: BROWSERS[@browser.to_s])
  end

  def open_browser
    # If memory is an issue then headless browsing can be added here
    # In my experience this has not create significant improvements
    @driver = Selenium::WebDriver.for @browser, 
      service: @service
    @driver.manage.delete_all_cookies
    @driver.manage.window.maximize
    p "Started browser, cleaned cookies and maximized the screen"
  end

  def navigate_to_url
    @selector_search_engine.search
    p "Added keyword to url for faster testing"
  end

  def retrieve_top_10_results
    @selector_search_engine.get_top_10_results
  end

  def save_results_to_file
    @selector_search_engine.save_results_to_file(SEARCH_ENGINES.key(@search_engine))
  end

  private
  def instantiate_search_engine_class 
    @selector_search_engine = Object::const_get("#{SEARCH_ENGINES.key(@search_engine).camel_case}Selectors").new(@driver, @search_term, @search_engine)   
  end
end
