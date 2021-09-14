# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190929204203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ability_contents", force: :cascade do |t|
    t.integer  "pme_ability_id"
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "ability_contents", ["pme_ability_id"], name: "index_ability_contents_on_pme_ability_id", using: :btree

  create_table "advices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alternatives", force: :cascade do |t|
    t.text     "texto"
    t.boolean  "correcta"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "alternatives", ["question_id"], name: "index_alternatives_on_question_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "student_id"
    t.string   "letra"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "proccess_instrument_id"
    t.boolean  "correct"
  end

  add_index "answers", ["proccess_instrument_id"], name: "index_answers_on_proccess_instrument_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["student_id"], name: "index_answers_on_student_id", using: :btree

  create_table "assignature_abilities", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "assignature_id"
  end

  add_index "assignature_abilities", ["assignature_id"], name: "index_assignature_abilities_on_assignature_id", using: :btree

  create_table "assignatures", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "short_name"
    t.integer  "priority"
  end

  create_table "assignatures_grades", id: false, force: :cascade do |t|
    t.integer "assignature_id", null: false
    t.integer "grade_id",       null: false
  end

  create_table "assigned_schools", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "axes", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "assignature_id"
  end

  add_index "axes", ["assignature_id"], name: "index_axes_on_assignature_id", using: :btree

  create_table "axes_contents", force: :cascade do |t|
    t.integer  "axis_id"
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "axes_contents", ["axis_id"], name: "index_axes_contents_on_axis_id", using: :btree

  create_table "axis_programs", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "assignature_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "axis_programs", ["assignature_id"], name: "index_axis_programs_on_assignature_id", using: :btree

  create_table "bloom_abilities", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "buy_orders", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "monto"
    t.date     "fecha"
    t.string   "numero"
    t.string   "comentario"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "buy_orders", ["order_id"], name: "index_buy_orders_on_order_id", using: :btree

  create_table "color_ranges", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "min"
    t.integer  "max"
    t.string   "color"
    t.integer  "evaluation_type_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "assignature_id"
    t.integer  "level_id"
  end

  add_index "color_ranges", ["assignature_id"], name: "index_color_ranges_on_assignature_id", using: :btree
  add_index "color_ranges", ["evaluation_type_id"], name: "index_color_ranges_on_evaluation_type_id", using: :btree
  add_index "color_ranges", ["level_id"], name: "index_color_ranges_on_level_id", using: :btree

  create_table "communes", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "communes", ["region_id"], name: "index_communes_on_region_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.integer  "contact",    limit: 8
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "assignature_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "contents", ["assignature_id"], name: "index_contents_on_assignature_id", using: :btree

  create_table "difficulty_levels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluation_types", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "short_name"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "evaluation_type_id"
    t.integer  "assignature_id"
    t.integer  "level_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "year"
    t.string   "pdfguide_file_name"
    t.string   "pdfguide_content_type"
    t.integer  "pdfguide_file_size"
    t.datetime "pdfguide_updated_at"
  end

  add_index "evaluations", ["assignature_id"], name: "index_evaluations_on_assignature_id", using: :btree
  add_index "evaluations", ["evaluation_type_id"], name: "index_evaluations_on_evaluation_type_id", using: :btree
  add_index "evaluations", ["level_id"], name: "index_evaluations_on_level_id", using: :btree

  create_table "evaluations_questions", id: false, force: :cascade do |t|
    t.integer "evaluation_id", null: false
    t.integer "question_id",   null: false
  end

  create_table "fact_status_types", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fact_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "fact_status_type_id"
    t.string   "comentario"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "fact_statuses", ["fact_status_type_id"], name: "index_fact_statuses_on_fact_status_type_id", using: :btree
  add_index "fact_statuses", ["order_id"], name: "index_fact_statuses_on_order_id", using: :btree

  create_table "feed_forms", force: :cascade do |t|
    t.integer  "feedback_id"
    t.integer  "feed_item_id"
    t.integer  "feed_score_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "feed_forms", ["feed_item_id"], name: "index_feed_forms_on_feed_item_id", using: :btree
  add_index "feed_forms", ["feed_score_id"], name: "index_feed_forms_on_feed_score_id", using: :btree
  add_index "feed_forms", ["feedback_id"], name: "index_feed_forms_on_feedback_id", using: :btree

  create_table "feed_items", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feed_scores", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "comentario"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "score",      default: 0
  end

  add_index "feedbacks", ["order_id"], name: "index_feedbacks_on_order_id", using: :btree

  create_table "froala_images", force: :cascade do |t|
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "letra"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "level_id"
  end

  add_index "grades", ["level_id"], name: "index_grades_on_level_id", using: :btree

  create_table "grades_students", id: false, force: :cascade do |t|
    t.integer "grade_id",   null: false
    t.integer "student_id", null: false
  end

  create_table "group_questions", force: :cascade do |t|
    t.text     "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guides", force: :cascade do |t|
    t.integer  "instrument_id"
    t.integer  "question_id"
    t.integer  "alternative_id"
    t.integer  "question_index"
    t.string   "alternative_index"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "guides", ["alternative_id"], name: "index_guides_on_alternative_id", using: :btree
  add_index "guides", ["instrument_id"], name: "index_guides_on_instrument_id", using: :btree
  add_index "guides", ["question_id"], name: "index_guides_on_question_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "instrument_alternatives_positions", force: :cascade do |t|
    t.integer  "instrument_id"
    t.integer  "question_id"
    t.integer  "alternative_id"
    t.integer  "instrument_questions_position_id"
    t.string   "position"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "instrument_alternatives_positions", ["alternative_id"], name: "index_instrument_alternatives_positions_on_alternative_id", using: :btree
  add_index "instrument_alternatives_positions", ["instrument_id"], name: "index_instrument_alternatives_positions_on_instrument_id", using: :btree
  add_index "instrument_alternatives_positions", ["instrument_questions_position_id"], name: "instrument_questions_position_id", using: :btree
  add_index "instrument_alternatives_positions", ["question_id"], name: "index_instrument_alternatives_positions_on_question_id", using: :btree

  create_table "instrument_questions_positions", force: :cascade do |t|
    t.integer  "instrument_id"
    t.integer  "question_id"
    t.integer  "position"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "instrument_questions_positions", ["instrument_id"], name: "index_instrument_questions_positions_on_instrument_id", using: :btree
  add_index "instrument_questions_positions", ["question_id"], name: "index_instrument_questions_positions_on_question_id", using: :btree

  create_table "instruments", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "evaluation_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "instruments", ["evaluation_id"], name: "index_instruments_on_evaluation_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "numero"
    t.date     "fecha"
    t.integer  "monto"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.string   "comentario"
    t.boolean  "paid"
  end

  create_table "learning_goals", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "assignature_id"
    t.integer  "level_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "learning_goals", ["assignature_id"], name: "index_learning_goals_on_assignature_id", using: :btree
  add_index "learning_goals", ["level_id"], name: "index_learning_goals_on_level_id", using: :btree

  create_table "learning_goals_units", force: :cascade do |t|
    t.integer "learning_goal_id"
    t.integer "unit_id"
    t.string  "description"
  end

  add_index "learning_goals_units", ["learning_goal_id"], name: "index_learning_goals_units_on_learning_goal_id", using: :btree
  add_index "learning_goals_units", ["unit_id"], name: "index_learning_goals_units_on_unit_id", using: :btree

  create_table "learning_questions", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "learning_goal_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string   "nombre"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "status_type_id"
    t.string   "comentario"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "year"
    t.string   "paymethod"
    t.string   "contract"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "number"
    t.string   "licitacion"
    t.boolean  "can_download",    default: true
    t.integer  "service_type_id"
    t.integer  "payer_type_id"
    t.integer  "pay_status_id"
    t.integer  "status_type_id"
    t.date     "paydate"
  end

  add_index "orders", ["pay_status_id"], name: "index_orders_on_pay_status_id", using: :btree
  add_index "orders", ["payer_type_id"], name: "index_orders_on_payer_type_id", using: :btree
  add_index "orders", ["service_type_id"], name: "index_orders_on_service_type_id", using: :btree
  add_index "orders", ["status_type_id"], name: "index_orders_on_status_type_id", using: :btree

  create_table "pay_statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nombre"
    t.string   "short_name"
  end

  create_table "payer_types", force: :cascade do |t|
    t.string   "nombre"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "monto"
    t.string   "comentario"
    t.date     "fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "paid"
  end

  create_table "pme_abilities", force: :cascade do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "assignature_id"
  end

  add_index "pme_abilities", ["assignature_id"], name: "index_pme_abilities_on_assignature_id", using: :btree

  create_table "proc_type_fathers", force: :cascade do |t|
    t.string   "nombre"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proc_types", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "short_name"
    t.integer  "proc_type_father_id"
    t.integer  "priority"
  end

  add_index "proc_types", ["proc_type_father_id"], name: "index_proc_types_on_proc_type_father_id", using: :btree

  create_table "proccess_instruments", force: :cascade do |t|
    t.integer "proccess_id"
    t.integer "instrument_id"
    t.integer "grade_id"
    t.boolean "report_generated", default: false
  end

  add_index "proccess_instruments", ["grade_id"], name: "index_proccess_instruments_on_grade_id", using: :btree

  create_table "proccesses", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "proc_type_id"
    t.integer  "monto"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "fecha"
    t.boolean  "billed"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "texto"
    t.integer  "assignature_id"
    t.integer  "level_id"
    t.integer  "bloom_ability_id"
    t.integer  "axes_content_id"
    t.integer  "ability_content_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "difficulty_level_id"
    t.integer  "content_id"
    t.integer  "axis_id"
    t.integer  "pme_ability_id"
    t.integer  "assignature_ability_id"
    t.integer  "axis_program_id"
    t.integer  "group_question_id"
    t.integer  "advice_id"
  end

  add_index "questions", ["ability_content_id"], name: "index_questions_on_ability_content_id", using: :btree
  add_index "questions", ["advice_id"], name: "index_questions_on_advice_id", using: :btree
  add_index "questions", ["assignature_ability_id"], name: "index_questions_on_assignature_ability_id", using: :btree
  add_index "questions", ["assignature_id"], name: "index_questions_on_assignature_id", using: :btree
  add_index "questions", ["axes_content_id"], name: "index_questions_on_axes_content_id", using: :btree
  add_index "questions", ["axis_id"], name: "index_questions_on_axis_id", using: :btree
  add_index "questions", ["axis_program_id"], name: "index_questions_on_axis_program_id", using: :btree
  add_index "questions", ["bloom_ability_id"], name: "index_questions_on_bloom_ability_id", using: :btree
  add_index "questions", ["content_id"], name: "index_questions_on_content_id", using: :btree
  add_index "questions", ["difficulty_level_id"], name: "index_questions_on_difficulty_level_id", using: :btree
  add_index "questions", ["group_question_id"], name: "index_questions_on_group_question_id", using: :btree
  add_index "questions", ["level_id"], name: "index_questions_on_level_id", using: :btree
  add_index "questions", ["pme_ability_id"], name: "index_questions_on_pme_ability_id", using: :btree

  create_table "questions_units", id: false, force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "unit_id",     null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.string   "roman"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remedials", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "content_id"
    t.integer  "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "remedials", ["content_id"], name: "index_remedials_on_content_id", using: :btree
  add_index "remedials", ["level_id"], name: "index_remedials_on_level_id", using: :btree

  create_table "reports_bypasses", force: :cascade do |t|
    t.string   "nombre"
    t.string   "report_file_name"
    t.string   "report_content_type"
    t.integer  "report_file_size"
    t.datetime "report_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "nombre"
    t.string   "rut"
    t.string   "direccion"
    t.string   "email"
    t.string   "telefono"
    t.text     "info_contacto"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "rbd"
    t.string   "dependencia"
    t.integer  "commune_id"
    t.string   "socialmean"
    t.string   "logo"
  end

  create_table "service_types", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_types", force: :cascade do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "short_name"
  end

  create_table "students", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "rut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "units", force: :cascade do |t|
    t.integer  "assignature_id"
    t.integer  "level_id"
    t.string   "numero"
    t.text     "descripcion"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "units", ["assignature_id"], name: "index_units_on_assignature_id", using: :btree
  add_index "units", ["level_id"], name: "index_units_on_level_id", using: :btree

  create_table "user_types", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.string   "code"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "second_name"
    t.integer  "user_type_id"
    t.string   "tel"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "ability_contents", "pme_abilities"
  add_foreign_key "alternatives", "questions"
  add_foreign_key "answers", "proccess_instruments"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "students"
  add_foreign_key "assignature_abilities", "assignatures"
  add_foreign_key "axes", "assignatures"
  add_foreign_key "axes_contents", "axes"
  add_foreign_key "axis_programs", "assignatures"
  add_foreign_key "buy_orders", "orders"
  add_foreign_key "color_ranges", "assignatures"
  add_foreign_key "color_ranges", "evaluation_types"
  add_foreign_key "color_ranges", "levels"
  add_foreign_key "communes", "regions"
  add_foreign_key "contents", "assignatures"
  add_foreign_key "evaluations", "assignatures"
  add_foreign_key "evaluations", "evaluation_types"
  add_foreign_key "evaluations", "levels"
  add_foreign_key "fact_statuses", "fact_status_types"
  add_foreign_key "fact_statuses", "orders"
  add_foreign_key "feed_forms", "feed_items"
  add_foreign_key "feed_forms", "feed_scores"
  add_foreign_key "feed_forms", "feedbacks"
  add_foreign_key "feedbacks", "orders"
  add_foreign_key "grades", "levels"
  add_foreign_key "guides", "alternatives"
  add_foreign_key "guides", "instruments"
  add_foreign_key "guides", "questions"
  add_foreign_key "instrument_alternatives_positions", "alternatives"
  add_foreign_key "instrument_alternatives_positions", "instruments"
  add_foreign_key "instrument_alternatives_positions", "questions"
  add_foreign_key "instrument_questions_positions", "instruments"
  add_foreign_key "instrument_questions_positions", "questions"
  add_foreign_key "instruments", "evaluations"
  add_foreign_key "learning_goals", "assignatures"
  add_foreign_key "learning_goals", "levels"
  add_foreign_key "orders", "pay_statuses"
  add_foreign_key "orders", "payer_types"
  add_foreign_key "orders", "service_types"
  add_foreign_key "orders", "status_types"
  add_foreign_key "pme_abilities", "assignatures"
  add_foreign_key "proc_types", "proc_type_fathers"
  add_foreign_key "proccess_instruments", "grades"
  add_foreign_key "questions", "ability_contents"
  add_foreign_key "questions", "advices"
  add_foreign_key "questions", "assignature_abilities"
  add_foreign_key "questions", "assignatures"
  add_foreign_key "questions", "axes"
  add_foreign_key "questions", "axes_contents"
  add_foreign_key "questions", "axis_programs"
  add_foreign_key "questions", "bloom_abilities"
  add_foreign_key "questions", "contents"
  add_foreign_key "questions", "difficulty_levels"
  add_foreign_key "questions", "group_questions"
  add_foreign_key "questions", "levels"
  add_foreign_key "questions", "pme_abilities"
  add_foreign_key "remedials", "contents"
  add_foreign_key "remedials", "levels"
  add_foreign_key "units", "assignatures"
  add_foreign_key "units", "levels"
  add_foreign_key "users", "user_types"
end
