require "factory_bot"
require "rails_helper"

RSpec.describe Author, type: :model do
  let!(:user) { FactoryBot.create(:user)}
  let!(:author) { FactoryBot.create(:author)}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}
  let!(:review) { FactoryBot.create(:review, user_id: user.id, book_id: book.id )}

  describe "associations" do
    it { should have_many(:books) }
  end

  describe "full name" do
    it "is right" do
      expect(author.full_name).to eq("#{author.first_name} #{author.last_name}")
    end
  end

end