# 50.times do
#   user = User.create! :first_name => Faker::Name.first_name,
#                       :last_name => Faker::Name.unique.last_name,
#                       :email => Faker::Internet.unique.email,
#                       :bio => Faker::Quote.famous_last_words,
#                       :is_admin => false,
#                       :password => 'asdasd',
#                       :password_confirmation => 'asdasd'
# end

# 100.times do
#   author = Author.create! :first_name => Faker::Name.first_name,
#                         :last_name => Faker::Name.unique.last_name,
#                         :country => Faker::Address.country
# end

# 1000.times do
#   book = Book.create! :title => Faker::Book.unique(max_retries = 1_000_000).title,
#                       :title_sk => Faker::Book.title,
#                       :isbn => Faker::Code.unique.isbn,
#                       :author_id => rand(5..104)
# end

# 1000.times do
#   record = ReadingRecord.create! :user_id => rand(17..68),
#                       :book_id => rand(16..1054),
#                       :status => rand(0..2)
# end

1000.times do
  record = ReadingRecord.where(status: 2).sample
  review = Review.create! :user_id => record.user_id,
                          :book_id => record.book_id,
                          :score => rand(0..10),
                          :body => Faker::Quotes::Shakespeare.hamlet_quote
end