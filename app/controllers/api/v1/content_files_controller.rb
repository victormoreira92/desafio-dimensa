module Api
  module V1
    class ContentFilesController < ApplicationController

      def process_csv
       content_file = ContentFile.new(content_file_params)
       resp = ContentFilesController.new(content_file).call

       if resp[:error].nil?
         render json: { status: :success, message: resp[:message] }, status: :ok
       else
         render json: { status: :error, message: resp[:error] }, status: :unprocessable_entity
       end
      end

      private
      def content_file_params
        params.require(:content_file).permit(:content_file_name, :file_data)
      end
    end
  end
end
