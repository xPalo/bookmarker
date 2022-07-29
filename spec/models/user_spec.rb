require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:author) { FactoryBot.create(:author, user_id: user.id )}

  describe ".without_author" do
    it "returns users without authors" do
      expect(described_class.without_author).to eq([])
    end
  end

  describe ".with_author" do
    it "returns users with authors" do
      expect(described_class.with_author).to eq([user])
    end
  end

  describe ".author_count" do
    it "returns count of authors" do
      expect(user.author_count).to eq(1)
    end
  end

  describe "associations" do
    it { should have_many(:authors) }
  end

end