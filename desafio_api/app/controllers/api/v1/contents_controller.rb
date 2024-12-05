module Api
  module V1
    class ContentsController < ApplicationController
      has_scope :by_genre
      has_scope :by_year_range, using: %i[started_at ended_at], type: :hash
      has_scope :by_cast
      has_scope :by_country
      has_scope :by_type_content
      has_scope :by_title

      #api/v1/contents
      def index
        binding.pry
        @contents = apply_scopes(Content.order(year: :desc)).all
        render json: @contents
      end
    end
  end
end
