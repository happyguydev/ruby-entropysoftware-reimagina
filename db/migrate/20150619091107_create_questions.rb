class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :texto
      t.references :assignature, index: true, foreign_key: true
      t.references :level, index: true, foreign_key: true
      t.references :bloom_ability, index: true, foreign_key: true
      t.references :axes_content, index: true, foreign_key: true
      t.references :ability_content, index: true, foreign_key: true
      t.references :unit, index: true, foreign_key: true
      t.references :learning_goal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
