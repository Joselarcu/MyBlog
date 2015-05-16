class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  load_and_authorize_resource :only => [:new, :edit, :destroy] 
  

  
  def index
    if params[:category] and not params[:category].empty?
      @posts = Post.where(:category => params[:category]).paginate(:page => params[:page], :per_page => 5)
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
    @post = Post.new(:title => post_params[:title],:language => post_params[:language],
                     :category => post_params[:category], :content => post_params[:content])
    tags = post_params[:tag][:tag_content]
    if @post.save
      unless tags.nil?
        create_tags(@post, tags)
      end
      redirect_to posts_path
      flash[:success] = t('post.message.created_success')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_back_or_to post_path(params[:id]), :success => t('post.message.updated_success')
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:language, :category, :tag => [:tag_content])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def create_tags post, tags
    tags.split(",").each do |tag_content|
      tag = Tag.find_or_create_by(:tag_content => tag_content.capitalize)
      post.tags << tag unless post.tags.include? tag
    end
  end

end
