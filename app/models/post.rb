class Post < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  # min length, max length, many more options available
  # if validation failed, attaches errors - post.errors, post.errors.full_messages
  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
end