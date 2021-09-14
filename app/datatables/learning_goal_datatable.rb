class LearningGoalDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :learning_goal_path, :edit_learning_goal_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(LearningGoal.nombre Level.nombre Assignature.nombre LearningGoalsUnit.description Unit.numero)
end

def searchable_columns
  # Declare strings in this format: ModelName.column_name
  @searchable_columns ||= %w(LearningGoal.nombre Level.nombre Assignature.nombre LearningGoalsUnit.description Unit.numero)
end

private

def data
  records.map do |record|
    [
      # comma separated list of the values for each cell of a table row
      # example: record.attribute,
      record.try(:learning_goal).try(:nombre).try(:truncate, 10),
      record.try(:learning_goal).level.try(:nombre),
      record.try(:learning_goal).assignature.try(:nombre),
      record.try(:description).try(:truncate, 50),
      record.try(:unit).try(:numero),
      edit_and_delete_buttons(record.try(:learning_goal))
      ]
  end
end

def get_raw_records
  # insert query here
  #LearningGoal.joins(:level,:assignature).all
  LearningGoalsUnit.joins(:learning_goal => [:assignature,:level]).joins(:unit)
end

def edit_and_delete_buttons record

  edit_icon = '<i class="fa fa-pencil"></i>'.html_safe
  delete_icon = '<i class="fa fa-trash-o"></i>'.html_safe

  link_to(edit_icon, edit_learning_goal_path(record)) + 
  link_to(delete_icon, learning_goal_path(record), method: :delete, data: { confirm: 'Seguro que quieres eliminar el registro?' })

end
# ==== Insert 'presenter'-like methods below if necessary
end
