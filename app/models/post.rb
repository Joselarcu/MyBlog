class Post < ActiveRecord::Base

  has_many :comments, dependent: :destroy

  before_save { title.capitalize! }
  before_save { content.capitalize! }


  default_scope order('created_at DESC')
  validates :title, :content, :presence => true, :length => { :minimum => 6 }, :uniqueness => {
    :message => "The title is already in use" }
  validates :content, :presence => true, :length => { :minimum => 20 }
  validates :language, :presence => true, :length => { :maximum => 2 , :minimum => 2 }
end
