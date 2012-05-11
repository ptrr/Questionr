class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :question_type
      t.integer :form_id
      t.integer :order
      t.boolean :required
      t.timestamps
    end
  end
end
