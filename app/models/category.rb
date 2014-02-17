class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 2}, uniqueness: true

  after_validation :generate_slug!

  def to_param
    if self.slug.blank?
      generate_slug
      self.save
    end
    self.slug
  end

  # improved slugging not added beacuse categories must be unique anyway
  def generate_slug!
    self.slug = self.name.gsub(' ', '_').gsub(/\W/, '').downcase
  end
end
