require "rails_helper"

RSpec.describe Author, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:author) { FactoryBot.create(:author, user_id: user.id )}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  describe "associations" do
    it { should have_many(:books) }
    it { should belong_to(:user) }
  end

end