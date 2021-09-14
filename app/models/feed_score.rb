class FeedScore < ActiveRecord::Base
    resourcify
    has_many :feed_forms
    has_many :feedbacks, :through => :feed_forms

    validates :nombre, :score, presence: true
end
