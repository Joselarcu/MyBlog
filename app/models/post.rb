class Post < ActiveRecord::Base

  before_save { title.capitalize! }
  before_save { content.capitalize! }
  before_destroy :delete_tags

  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :tags, :join_table => :posts_tags
  accepts_nested_attributes_for :tags

  default_scope order('created_at DESC')
  validates :title, :content, :presence => true, :length => { :minimum => 6 }, :uniqueness => {
    :message => "The title is already in use" }
  validates :content, :presence => true, :length => { :minimum => 20 }
  validates :language, :presence => true, :length => { :maximum => 2 , :minimum => 2 }


  def delete_tags
    self.tags.each do |tag|
      if tag.posts.count == 1
        tag.destroy
      end
    end
  end
end
