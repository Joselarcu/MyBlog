module ApplicationHelper

  def get_five_latest_posts
    @posts = Post.all.sort.reverse.first(5)
  end

  def get_index_nearest_end_word_320(str)
    aux = str[320,str.length]
    aux.index(/[,.;' ']/) + 320
  end

  def get_existing_categories
    Post.select(:category).map(&:category).uniq
  end
 
end
