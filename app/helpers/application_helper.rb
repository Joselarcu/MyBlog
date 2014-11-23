module ApplicationHelper

  def get_five_latest_posts
    @posts = Post.all.sort.first(5)
  end
end
