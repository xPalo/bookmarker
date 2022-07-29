require "factory_bot"
require "rails_helper"

RSpec.describe Book, type: :model do
  let!(:user) { FactoryBot.create(:user)}
  let!(:author) { FactoryBot.create(:author)}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  let!(:review) { FactoryBot.create(:review, user_id: user.id, book_id: book.id )}

  describe "associations" do
    it { should belong_to(:author) }
    it { should have_many(:reviews) }
    it { should have_many(:reading_records) }
  end

  describe "rating" do
    it "is right" do
      expect(book.rating/10).to eq(review.score)
    end
  end

  describe "ratings" do
    it "is right" do
      expect(book.ratings).to eq(1)
    end
  end

end