class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :content, :presence => true, :length => { :minimum => 3 }
  validates :user_id, presence: true

  default_scope -> { order('id') }

  def author 
    User.find(self.user_id)
  end

  def author? current_user
    self.user_id == current_user.id
  end
end
