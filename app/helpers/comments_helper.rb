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
end
