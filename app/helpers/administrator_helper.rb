module AdministratorHelper

	def total_users
		User.all.length
	end

	def total_comments user
		user.comments.length
	end

	def number_of_times_use tag
		tag.posts.length
	end

	def get_comment_user comment
		user = User.find(comment.user_id).name
	end

	def get_post_comment comment
		post = Post.find(comment.post_id)
	end

	def get_post_tag tag
		unless tag.posts.empty?
			@post = Post.find(tag.posts.first)
		end
	end
end
