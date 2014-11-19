class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :content, :presence => true, :length => { :minimum => 3 }
  validates :user_id, presence: true
end
