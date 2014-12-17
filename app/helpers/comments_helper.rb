module CommentsHelper
  def is_comment_owner?(comment, current_user)
    comment.user_id == current_user.id
  end

  def comments?(post)
    post.comments.nil?
  end

  def find_user(id)
    User.find(id)
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
