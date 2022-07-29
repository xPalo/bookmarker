require "rails_helper"

RSpec.describe AuthorsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:author) { FactoryBot.create(:author, user_id: user.id )}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  describe "GET #index" do
    context "signed" do
      before {sign_in user}
      it "returns HTTP 200 Success" do
        get :index
        expect(response.status).to eq(200)
      end
    end
    context "unsigned" do
      it "returns HTTP 302 Redirect" do
        get :index
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET #new" do
    context "signed" do
      before {sign_in user}
      it "returns HTTP 200 Success" do
        get :new
        expect(response.status).to eq(200)
      end
    end
    context "unsigned" do
      it "returns HTTP 302 Redirect" do
        get :new
        expect(response.status).to eq(302)
      end
    end
  end

end