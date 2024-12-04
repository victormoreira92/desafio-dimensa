module Api
  module V1
    class ContentsController < ApplicationController
      has_scope :by_genre
      has_scope :by_year_range
      has_scope :by_cast
      has_scope :by_country
      has_scope :by_type_content
      has_scope :by_title

      def index
        @contents = apply_scopes(Content.order(year: :desc)).all
        render json: @contents
      end
    end
  end
end
