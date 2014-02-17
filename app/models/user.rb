class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5} 

  after_validation :generate_slug!

  def to_param
    if self.slug.blank?
      generate_slug
      self.save
    end
    self.slug
  end

  # improved slugging not added because username must be unique anyway
  def generate_slug!
    self.slug = self.username.gsub(' ', '_').gsub(/\W/, '').downcase
  end
end