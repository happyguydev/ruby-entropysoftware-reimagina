class SchoolFeedbackDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :update_client_feedback_path

  def sortable_columns
    @sortable_columns ||= %w(Order.paymethod Order.licitacion Order.created_at Order.feedback.try(:score).to_s)
  end

  def searchable_columns
    @searchable_columns ||= %w(Order.paymethod Order.licitacion)
  end

  private

  def data
    records.map do |record|
      [
        record.paymethod,
        record.licitacion,
        record.created_at,
        get_feed_rating(record),
        record.feedback.try(:comentario).to_s,
        provide_feedback(record)
      ]
    end
  end

  def get_feed_rating record
    feed_score_ids = record.feedback.try(:feed_forms).collect(&:feed_score_id).compact rescue nil
    score = (FeedScore.find(feed_score_ids).collect(&:score).try(:sum)/3) if feed_score_ids.present?
    rating = case score
              when 0..24 then 1
              when 25..49 then 2
              when 50..74 then 3
              when 75..99 then 4
              when 100 then 5
              end
  end

  def get_raw_records
    Order.where(id: options[:order_ids])
  end

  def provide_feedback record
    if record.feedback.present?
      'You have already submitted the feedback!'
    else
      link_to('Provide Feedback', '/school_clients/update_feedback?order_id='+record.id.to_s+'&feedback_id='+ record.try(:feedback).try(:id).to_s, title: 'Edit your feedback', remote: true)
    end
  end

end
