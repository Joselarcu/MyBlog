class PostsController < ApplicationController
  before_action :get_post, only: [ :show, :edit, :update ]
  load_and_authorize_resource :only => [:new, :edit, :destroy,] 

  
  def index
    if params[:category]
      #@posts = Post.find :all,:conditions => ['category IN (?)', params[:category]]
      @posts = Post.where(:category => params[:category]).paginate(:page => params[:page], :per_page => 5)
      #redirect_back_or_to post_path(19), :success => "#{params[:category]}"
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
    session[:return_to_url] = post_path(@post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_back_or_to posts_path, :success => "Post created successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_back_or_to post_path(params[:id]), :success => "Post updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:language, :category)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end
