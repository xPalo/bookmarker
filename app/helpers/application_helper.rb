module ApplicationHelper

  def current_class?(test_path, color="")
    return "active #{color}" if request.path == test_path
    " "
  end

  def user_avatar(user, size=150)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
    else
      "/default_avatar.png".variant(resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
    end
  end

  # def open_movie(path)
  #
  # end
end