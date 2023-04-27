# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def index
  end

  def search
    search_term = params[:search_term].to_s.strip

    if search_term.empty?
      @error_message = 'Please enter a search term'
      render :index
    else
      fetch_result = RepositoriesFetcher.call(search_term)

      @repositories = fetch_result[:repositories]
      @total_count = fetch_result[:total_count]
      @error_message = fetch_result[:error_message]

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
