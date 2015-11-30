class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :joke
  belongs_to :user

  def upvotes_score
    self.get_upvotes.count
  end
  
end
