module UsersHelper

  def render_header
    if admin_user?
      content = render "shared/layout/header/admin"
    else normal_user?
      content = render "shared/layout/header/user"
    end
    content
  end

  def image_avatar user, size
    path = user.avatar? ? user.avatar : Settings.user.avatar_default_path
    image_tag(path, size: "#{size}")
  end
end
