class QuestionDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :question_path, :edit_question_path

  def sortable_columns

    @sortable_columns ||= %w(Question.id Question.texto Assignature.nombre Level.nombre Content.nombre BloomAbility.nombre AssignatureAbility.nombre Axis.nombre AxisProgram.nombre PmeAbility.nombre DifficultyLevel.name Question.group_question_id)

  end

  def searchable_columns

    @searchable_columns ||= %w(Question.id Question.texto Assignature.nombre Level.nombre Content.nombre BloomAbility.nombre AssignatureAbility.nombre Axis.nombre AxisProgram.nombre PmeAbility.nombre DifficultyLevel.name Question.group_question_id)


  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        add_question_button(record),
        link_to(record.try(:texto).html_safe, question_path(record)),
        record.assignature.try(:nombre),
        record.level.try(:nombre),
        record.content.try(:nombre),
        record.bloom_ability.try(:nombre),
        record.assignature_ability.try(:nombre),
        record.axis.try(:nombre),
        record.axis_program.try(:nombre),
        record.pme_ability.try(:nombre),
        record.difficulty_level.try(:name),
        record.try(:group_question_id)

        ]
    end
  end

  def get_raw_records

    Question.includes(:assignature,:level,:content,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:difficulty_level, :learning_goals).references(:question).distinct
#    Question
#    .includes(:assignature, :content,:level, :difficulty_level)
#    .references(:assignature, :content,:level, :difficulty_level).distinct
    #Question.all
   # Question.joins(:assignature,:level,:content,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:unit,:learning_goal,:difficulty_level,:group_question).references(:assignature,:level,:content,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:unit,:learning_goal,:difficulty_level,:group_question).distinct
    #Question.includes(:assignature => :contents,:level,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:unit,:learning_goal,:difficulty_level, :group_question)
    #.references(:assignature => :contents ,:level,:bloom_ability,:assignature_ability,:axis,:axis_program, :pme_ability,:unit,:learning_goal,:difficulty_level, :group_question).distinct
    #Question.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
  def add_question_button(question)
    "<button class='btn btn-primary add-question-button' data-id='#{question.id}' data-texto='#{question.texto}' data-assignature='#{question.assignature.try(:nombre)}' data-level='#{question.level.try(:nombre)}' ><i class='fa fa-plus'/></button>"
end
end
