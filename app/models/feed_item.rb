class FeedItem < ActiveRecord::Base
    resourcify
    has_many :feed_forms
    has_many :feedbacks, :through => :feed_forms

    validates :nombre, presence: true
end
