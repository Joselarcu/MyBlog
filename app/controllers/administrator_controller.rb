class AdministratorController < ApplicationController
	
	authorize_resource :class => AdministratorController

	#display blog information and actions
  def show
  end

  def index_users
  	@users = User.all
  end

  def index_posts
  end

  def index_comments
  	@comments = Comment.all
 	end

 	def index_tags
 		@tags = Tag.all
 	end
end
