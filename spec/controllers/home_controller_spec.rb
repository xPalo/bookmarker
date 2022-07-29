require "rails_helper"

RSpec.describe HomeController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  # let!(:author) { FactoryBot.create(:author, user_id: user.id )}
  # let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  describe "GET #index" do
    it "returns HTTP 200 Success" do
      get :index
      expect(response.status).to eq(200)
    end
  end

end