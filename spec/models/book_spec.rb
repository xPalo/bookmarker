require "rails_helper"

RSpec.describe Book, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:author) { FactoryBot.create(:author, user_id: user.id )}
  let!(:book) { FactoryBot.create(:book, author_id: author.id )}

  describe "associations" do
    it { should belong_to(:author) }
  end

end