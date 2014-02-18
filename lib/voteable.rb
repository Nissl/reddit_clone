module Voteable
  # Concerns are a Rails thing
  extend ActiveSupport::Concern

  # Using normal metaprogramming
  # def self.included(base)
  #   base.send(:include, InstanceMethods)
  #   base.extend ClassMethods
  #   base.class_eval do
  #     my_class_method
  #   end
  # end

  # module InstanceMethods
  # end

  included do
    has_many :votes, as: :voteable
  end

  def total_votes 
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  module ClassMethods
    def my_class_method
      puts "this is a class method"
    end
  end
end