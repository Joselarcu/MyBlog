class Post < ActiveRecord::Base

  has_many :comments
  default_scope -> { order('id') }
  validates :title, :content, :presence => true, :length => { :minimum => 6 }, :uniqueness => {
    :message => "The title is already in use" }
  validates :content, :presence => true, :length => { :minimum => 20 }
  validates :language, :presence => true, :length => { :maximum => 2 , :minimum => 2 }
  
end
