class FeedbackDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :feedback_path


  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Order.number Order.year School.nombre)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Order.number Order.year School.nombre)
  end

  private

  def data
    records.map do |record|
      items_nombres = []
      score_score = []
      record.feedback.get_responses.map{|rs| items_nombres << rs[0]; score_score << rs[2];  } 
      p items_nombres
      p score_score
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.number,
        record.year,
        record.school.nombre,
        items_nombres.join('<br />'),
        score_score.join('<br />'),
        record.feedback.comentario
        ]
    end
  end

  def get_raw_records
    # insert query here
    Order.all.joins(:school,:feedback)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
