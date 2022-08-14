# frozen_string_literal: true

require_relative '../version'
require_relative 'browsers_list'
require_relative 'search_engines'

# This class manages all the options for the search_script
class ScriptOptions
  include Version
  include BrowsersList
  include SearchEngines
  attr_reader :browser, :search_engine, :search_term

  # Set default values
  def initialize
    @browser = DEFAULT_BROWSERS
    @search_engine = DEFAULT_SEARCH_ENGINE
    @search_term = "Cypress"
  end

  # Structure of different options (flags) available, including help and version
  def define_options parser
    parser.banner = 'Usage: ./run.rb [options]'
    parser.separator ''
    parser.separator 'Specific options:'
    select_browser(parser)
    select_search_engine(parser)
    text_to_search(parser)
    parser.on_tail('-h', '--help', 'Show different commands') do
      puts parser
      exit
    end
    parser.on_tail('-v', '--version', 'Show version') do
      puts VERSION
      exit
    end
  end

  # Browser selection, browser needs to be part of the BROWSERS list
  def select_browser(parser)
    acceptable_browsers_string = BROWSERS.keys.join(', ')

    parser.accept(BROWSERS) do |browser|
      abort "ERROR: Browser needs to be one of these (#{acceptable_browsers_string})" unless BROWSERS.key? browser
      browser
    end

    parser.on('-b', "--browser [default = #{DEFAULT_BROWSERS}]", BROWSERS, "Select browser (#{acceptable_browsers_string})" ) do |b|
      @browser = b
    end
  end

  # Search Engine selection, search engine needs to be part of the SEARCH_ENGINES list
  def select_search_engine(parser)
    search_engine_string = SEARCH_ENGINES.keys.join(', ')

    parser.accept(SEARCH_ENGINES) do |search_engine|
      abort "ERROR: Search engine needs to be one of these (#{search_engine_string})" unless SEARCH_ENGINES.key? search_engine
      search_engine
    end

    parser.on('-s', "--search_engine [default = #{DEFAULT_SEARCH_ENGINE}]", SEARCH_ENGINES, "Select search engine (#{search_engine_string})" ) do |s|
      @search_engine = s
    end
  end

  # Text to search
  def text_to_search(parser)
    parser.on('-t', "--text [default = #{@search_term}]", String, "Search term" ) do |t|
      @search_term = t
    end
  end
end
