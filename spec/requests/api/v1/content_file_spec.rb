require 'rails_helper'

RSpec.describe "Api::V1::ContentFiles", type: :request do
  describe "GET /attach_file" do
    it "returns http success" do
      get "/api/v1/content_file/attach_file"
      expect(response).to have_http_status(:success)
    end
  end

end
