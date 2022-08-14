# frozen_string_literal: true

module SearchEngines
  # List of search engines available
  # Matches the search engines with its url
  SEARCH_ENGINES = {
    'google' => 'https://www.google.com',
    'bing' => 'https://www.bing.com',
  }.freeze

  DEFAULT_SEARCH_ENGINE = SEARCH_ENGINES.keys[0]
end
