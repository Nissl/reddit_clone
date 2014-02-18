module Sluggable
  extend ActiveSupport::Concern

  included do 
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    if self.slug.blank?
      generate_slug
      self.save
    end
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    object = self.class.find_by(slug: the_slug)
    count = 2
    while object && object != self
      the_slug = append_suffix(the_slug, count)
      object = self.class.find_by(slug: the_slug)
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

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end