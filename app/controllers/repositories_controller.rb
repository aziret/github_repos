require 'net/http'

class RepositoriesController < ApplicationController
  def index
    @repositories ||= []
  end

  def search
    search_term = params[:search_term].to_s.strip

    if search_term.empty?
      @error_message = 'Please enter a search term'
      render :index
    else
      url = URI.parse("https://api.github.com/search/repositories?q=#{search_term}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url.request_uri)
      response = http.request(request)
      data = JSON.parse(response.body)

      if response.code.to_i == 200
        @repositories = data['items']
        @total_count = data['total_count']
      else
        @error_message = 'Failed to fetch repositories. Please try again later.'
      end

      if @repositories
        respond_to do |format|
          format.html { render :index }
          format.turbo_stream
        end
      else
        redirect_to root_path, locals: { error_message: @error_message }
      end
    end
  end
end
