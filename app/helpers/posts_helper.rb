module PostsHelper

  def content_without_html(content)
    content.gsub(/<\/?[^>]+>/, '');
  end
end
