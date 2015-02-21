module ApplicationHelper

  def get_five_latest_posts
    @posts = Post.all.sort.reverse.first(5)
  end

  def get_content_resume(str)
    if str.length > 320
      aux = str[320,str.length]
      index = aux.index(/[,.;' ']/) + 320
      str[0, index]  + "..."
    else
      str
    end
  end

  def get_existing_categories
    Post.select(:category).map(&:category).uniq
  end
 
end
