module Api
  module V1
    class ContentFilesController < ApplicationController

      def process_csv

        resp = ContentFileProcessor.new(content_file_params).call

       if resp[:errors].nil?
         render json: { status: :success, message:
         I18n.t('activerecord.success.models.content_files.process_csv', contents: resp[:message][:contents]) }, status: :ok
       else
         render json: { status: :error, message: resp[:errors] }, status: :unprocessable_entity
       end
      end

      private
      def content_file_params
        params.require(:content_file).permit(:content_file_name, :file_data)
      end
    end
  end
end
