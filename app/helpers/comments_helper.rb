module CommentsHelper
  def is_comment_owner?(comment, current_user)
    comment.user_id == current_user.id
  end
end
