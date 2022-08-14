#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'script/search_script'

search = SearchScript.new
options = search.parse(ARGV)

