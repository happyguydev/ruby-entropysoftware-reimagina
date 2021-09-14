class Feedback < ActiveRecord::Base
  resourcify
  belongs_to :order
  has_many :feed_forms, :dependent => :delete_all
  has_many :feed_items, :through => :feed_forms
  has_many :feed_scores, :through => :feed_forms
  validates_presence_of :comentario
  validates :order_id, presence: true, uniqueness: {message: "Orden ya evaluada"}
  

  
  def get_responses
    self.feed_forms.joins(:feed_item, :feed_score).select('feed_items.nombre, feed_scores.nombre, feed_scores.score').pluck('feed_items.nombre', 'feed_scores.nombre', 'feed_scores.score')
  end

  def self.get_responses_time_range(start_dateTime, end_dateTime)
    if start_dateTime.class.name != "DateTime" || end_dateTime.class.name != "DateTime"
      raise 'Esta funcion requiere inputs DateTime, Date no sirve para este metodo.'
    else
      FeedForm.where('feed_forms.created_at <= ?', start_dateTime).where('feed_forms.created_at >= ?', end_dateTime)
      .joins(:feed_item, :feed_score).group('feed_items.nombre').average('feed_scores.score')
    end
  end
end
