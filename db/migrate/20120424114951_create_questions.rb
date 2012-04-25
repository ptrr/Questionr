class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :type
      t.integer :form_id

      t.timestamps
    end
  end
end
