class TagsController < ApplicationController
  before_action :set_post, only: [:new, :create, :index, :edit, :update, :destroy]
  before_action :set_tag, only: [:edit, :update, :destroy]
  load_and_authorize_resource :only => [:new, :edit, :destroy] 

  def new
  	@tag = Tag.new
  end
  
  def create
  	@tag = Tag.find_or_create_by(tag_params)
    
    unless @tag.persisted?
      render 'new'
    else
      @post.tags << @tag unless @post.tags.include? @tag
      redirect_to post_path(@post)
      flash[:success] = t('tag.message.created_success')
    end
  end

  def index
  	@tags = @post.tags
  end


  def destroy
    @tag.posts.count == 1 ? @tag.destroy : @post.tags.delete(@tag)
  	 redirect_to post_tags_path(@post) 
     flash[:success] = t('tag.message.deleted_success')
  end

  def edit
  end
  
  def update
    if @tag.update_attributes(tag_params)
      redirect_back_or_to post_tags_path(), :success => t('tag.message.updated_success')
    else
      render 'edit'
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
  	params.require(:tag).permit(:tag_content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def tag_assigned?(post,tag)
    tags = post.tags.include? tag
  end
end
