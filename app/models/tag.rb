class Tag < ActiveRecord::Base

	has_and_belongs_to_many :posts, :join_table => :posts_tags

	before_save { tag_content.capitalize! }
	validates :tag_content, :presence => true, :length => { :minimum => 3 }

	

end
