# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :set_sorting_methods

  def index; end

  def search
    search_term = params[:search_term].to_s.strip

    if search_term.empty?
      @error_message = 'Please enter a search term'
      render :index
    else
      sort_by = params[:sort_by]
      order_direction = params[:order_direction]

      if sort_by.present?
        options = {
          sort: sort_by,
          order: order_direction || 'desc'
        }
      end

      fetch_result = RepositoriesFetcher.call(search_term, options || {})

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

  private

  def set_sorting_methods
    @sorting_criterias = RepositoriesFetcher::SORT_BY
    @order_direction = RepositoriesFetcher::ORDER_BY
  end
end
