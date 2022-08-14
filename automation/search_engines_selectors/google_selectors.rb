require_relative 'selectors_search_engine'

class GoogleSelectors < SelectorsSearchEngine
  attr_accessor :page_number, :google_results, :start_number

  def initialize(driver, search_term, search_engine)
    super(driver, search_term, search_engine)
    @page_number = 1
    @google_results = {}
    @start_number = 0
  end

  def search(change_page: "")
    search_command(change_page: change_page)
    wait_for_results({ xpath: "//table/tbody/tr/td[#{@page_number + 1}]/span"})
  end

  def get_top_10_results
    parent_element = @driver.find_elements(xpath: "//div[@data-header-feature='0']/parent::div")

    parent_element.each do |element|
      url = element.find_element(css: '[data-header-feature="0"] > div > a').attribute("href")
      title = element.find_element(css: '[data-header-feature="0"] > div > a > h3').text
      description = element.find_element(xpath: '//span[descendant::em]').text 

      @google_results[url] = { title: title, description: description }
      @google_results[url]["contains_keyword"] = "#{url} #{title} #{description}".downcase.include? @search_term
      break if @google_results.length == 10
    end

    if(@google_results.length < NUMBER_OF_RESULTS)
      @page_number += 1
      search(change_page: "&start=#{@start_number + 10}")
      get_top_10_results
    end
    pp "These are the top 10 results"
    pp @google_results
  end

  def save_results_to_file(search_engine_name)
    super {@google_results}
  end
end
