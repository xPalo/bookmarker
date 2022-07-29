require "factory_bot"
require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user)}
  let!(:author) { FactoryBot.create(:author)}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  let!(:review) { FactoryBot.create(:review, user_id: user.id, book_id: book.id )}

  describe "associations" do
    it { should have_many(:reviews) }
    it { should have_many(:reading_records) }
  end

end