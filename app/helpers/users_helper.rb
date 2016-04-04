module UsersHelper
  def render_header
    if admin_user?
      content = render "shared/layout/header/admin"
    else normal_user?
      content = render "shared/layout/header/user"
    end
    content
  end
end
