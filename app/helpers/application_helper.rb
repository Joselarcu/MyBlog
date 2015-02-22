module ApplicationHelper

  def get_five_latest_posts
    @posts = Post.all.sort.reverse.first(5)
  end

  def categories
    Post.select(:category).map(&:category).uniq
  end
 
end
