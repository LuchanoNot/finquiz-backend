require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /index" do
    context "when user is not logged in" do
      it "redirects to the login page" do
        get api_v1_home_index_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context "when user is logged in" do
      let(:user) { create(:user) }
      let(:headers) { user.create_new_auth_token }

      before do
        get api_v1_home_index_path, headers:
      end

      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
