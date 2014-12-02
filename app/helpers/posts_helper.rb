module PostsHelper

  def get_content_without_html(content)
    content.gsub(/<\/?[^>]+>/, '');
  end
end
