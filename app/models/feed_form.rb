class FeedForm < ActiveRecord::Base
  resourcify
  belongs_to :feedback
  belongs_to :feed_item
  belongs_to :feed_score
end
