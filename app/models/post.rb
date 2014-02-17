class Post < ActiveRecord::Base
  include Voteable
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  # min length, max length, many more options available
  # if validation failed, attaches errors - post.errors, post.errors.full_messages
  validates :title, presence: true, length: {minimum: 8}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  after_validation :generate_slug!

  def to_param
    if self.slug.blank?
      generate_slug
      self.save
    end
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by(slug: the_slug)
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split("_").last.to_i != 0
      return str.split("_").slice(0...-1).join('_') + '_' + count.to_s
    else
      return str + "_" + count.to_s
    end
  end

  def to_slug(name)
    # modified to match actual Reddit conventions, as best as I can guess them
    str = name.strip
    str.gsub!(' ', '_')
    str.gsub!(/\W/, '')
    str.downcase
  end
end