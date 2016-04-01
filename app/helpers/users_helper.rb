module UsersHelper
  def find_activities
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
end
