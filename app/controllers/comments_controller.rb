class CommentsController < ApplicationController
  before_action :get_comment, only:[:show, :edit, :update ]
  before_action :is_comment_owner?, only: [ :edit ]
  before_action :get_post, only: [ :new, :create, :edit, :update, :destroy, :index ]
  
  def show
    @user = current_user

  end

  def index
    @comments = Comment.where(post_id:  @post.id)
  end

  def new
    @comment = Comment.new
  end

  def create
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), :success => "comment created successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to post_path(@post), :success => "Comment updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    redirect_to post_path(@post) , :info => "comment deleted successfully"
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:user_id => current_user)
  end

  def get_comment
    @comment = Comment.find(params[:id])
  end

  def is_comment_owner?
   if current_user != nil && !( @comment.user_id == current_user.id )
      redirect_to post_path(@post) , :warning => "You are not authorized"
   end
  end

  def get_post
    @post = Post.find(params[:post_id])
  end

end
