require_relative 'selectors_search_engine'

class BingSelectors < SelectorsSearchEngine
  def initialize(driver, search_term, search_engine)
    super(driver, search_term, search_engine)
    @page_number = 1
    @bing_results = {}
    @start_number = 0
  end

  def search(change_page: "")
    search_command(change_page: change_page)
    wait_for_results({ xpath: "//li[@class='b_pag']/nav/ul/li[#{@page_number}]/a[not(@href)]"})
  end

  def get_top_10_results
    parent_element = @driver.find_elements(xpath: "//ol[@id='b_results']/li[@class='b_algo']")

    parent_element.each do |element|
      # Exclude nested search results
      next if @page_number == 1 && element.find_element(xpath: "//div[@class='b_rich']")
      url = element.find_element(css: 'h2 > a').attribute("href")
      title = element.find_element(css: 'h2 > a').text
      description = element.find_element(css: '.b_caption p').text 

      @bing_results[url] = { title: title, description: description }
      @bing_results[url]["contains_keyword"] = "#{url} #{title} #{description}".downcase.include? @search_term
      break if @bing_results.length == 10
    end

    if(@bing_results.length < NUMBER_OF_RESULTS)
      @page_number == 1 ? @page_number += 2 : @page_number +=1
      search(change_page: "&first=#{@start_number + 11}")
      get_top_10_results
    end
    pp "These are the top 10 results"
    pp @bing_results
  end

  def save_results_to_file(search_engine_name)
    super {@bing_results}
  end
end
