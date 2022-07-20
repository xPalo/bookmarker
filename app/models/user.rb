class User < ApplicationRecord

  has_many :reading_records
  has_many :reviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_one_attached :avatar
  validates :email, presence: true, uniqueness: true
  after_commit :add_default_avatar, on: %i[create update]

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def have_read(book_id)
    if ReadingRecord.where(user_id: self.id, book_id: book_id, status: "read").first != nil
      true
    else
      false
    end
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150^", crop: "150x150+0+0").processed
    else
      "/default_avatar.png"
    end
  end

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.password = Devise.friendly_token[0,20]
      end
    end
    user
  end

  private

  def add_default_avatar
    unless avatar.attached?
      image_file = File.open(Rails.root.join("app", "assets", "images", "default_avatar.png"))
      avatar.attach(
        io: image_file,
        filename: "default_avatar.png",
        content_type: "image/png"
      )
      image_file.rewind
    end
  end

end
