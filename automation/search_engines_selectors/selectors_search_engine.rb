# This is the parent class which have the methods that will be used for
# the different subclasses, these are the steps to follow for extracting the data
class SelectorsSearchEngine
  NUMBER_OF_RESULTS = 10

  def initialize(driver, search_term, search_engine)
    @driver = driver
    @search_term = search_term
    @search_engine = search_engine
  end
  
  def search 
    method_not_implemented_error
  end

  def get_top_10_results
    method_not_implemented_error
  end

  def save_results_to_file(search_engine_name)
    file_name = "results/#{@search_term}_#{search_engine_name}.json"
    File.write(file_name, yield.to_json )
    pp "Please the file that was created: #{file_name}"
  end

  protected

  def search_command(first_part_of_query: "search?q=", change_page: "")
    url = "#{@search_engine}/#{first_part_of_query}#{@search_term}#{change_page}"
    @driver.get url 
    pp "The url is #{url}"
  end

  def wait_for_results locator
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until{ @driver.find_element(locator) }
    pp "Waiting for this selector to show up in the screen #{locator}"
 end

  private
  
  def method_not_implemented_error
    raise "Please implement this method"
  end
end
