#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'

# This compared the results and creates a ranking
keyword = ARGV[0]

Dir.glob("results/#{keyword}_*.json").each_with_index do |f, i|
  instance_variable_set("@file_#{i}", JSON.parse(File.read(f)))
end

@file_0.each_key do |k|
  p @file_0[k] if @file_1.key?(k) 
end
