# frozen_string_literal: true

require_relative 'json_search/version'
require_relative 'json_search/record'
require_relative 'json_search/record_repository'
require_relative 'json_search/search_service'
require_relative 'json_search/duplicate_checker'
require_relative 'json_search/cli'

module JsonSearch
  class Error < StandardError; end
  # Your code goes here...
end
