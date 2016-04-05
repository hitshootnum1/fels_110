module UsersHelper
  def render_header
    render(admin_user? ? "shared/layout/header/admin" : "shared/layout/header/user")
  end
end
