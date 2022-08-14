# frozen_string_literal: true

require 'optparse'
require_relative 'script_options'
require_relative '../automation/automation_script'
require_relative 'search_engines'
require_relative 'browsers_list'

# This parses the options and calls the automation script
class SearchScript
  include SearchEngines
  include BrowsersList

  def parse(args)
    @options = ScriptOptions.new
    @args = OptionParser.new do |parser|
      @options.define_options(parser)
      parser.parse!(args)
    end
    Automation.new(browser: @options.browser.to_sym, 
                   search_engine: SEARCH_ENGINES[@options.search_engine],
                   search_term: @options.search_term)
  end
end
