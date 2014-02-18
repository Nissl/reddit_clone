class Comment < ActiveRecord::Base
  include Voteable
  #include VoteableJMo
  belongs_to :creator, class_name: "User", foreign_key: "user_id" 
  belongs_to :post
  
  validates :body, presence: true, length: {minimum: 3}
end
