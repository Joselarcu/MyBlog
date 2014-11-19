class User < ActiveRecord::Base
  rolify
  authenticates_with_sorcery!
  has_many :comments

  before_save { email.downcase! }
  before_save { username.downcase! }

  validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  #validates_presence_of :username
  #validates_uniqueness_of :username
  #validates_presence_of :email
  #validates_uniqueness_of :email

  VALID_USERNAME_REGEX = /\A[A-Za-z+]+[A-Za-z0-9_]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true, length: { minimum: 6, maximum: 12 },
                       on: :create
  validates :password, length: { minumum: 6, maximum: 12 }, on: :update, allow_blank: true
  validates :username, presence: true, length: { minimum: 3, maximum: 30 },
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
