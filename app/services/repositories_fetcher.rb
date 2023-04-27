# frozen_string_literal: true

require 'net/http'

class RepositoriesFetcher
  BASE_URL = 'https://api.github.com/search/repositories'
  SORT_BY = %w[stars forks help-wanted-issues updated].freeze
  ORDER_BY = %w[desc asc].freeze

  class << self
    def call(search_term, options = {})
      options_params = options.map { |k, v| [k, v].join('=') }.join('&')
      url = URI.parse(["#{BASE_URL}?q=#{search_term}", options_params].compact.join('&'))
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url.request_uri)
      response = http.request(request)
      data = JSON.parse(response.body)

      if response.code.to_i == 200
        repositories = data['items']
        total_count = data['total_count']
      else
        error_message = 'Failed to fetch repositories. Please try again later.'
      end

      {
        repositories:,
        total_count:,
        error_message:
      }
    end
  end
end
