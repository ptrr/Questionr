class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_label
      t.string :option_value
      t.references :question
      t.string :option_type
      t.string :order

      t.timestamps
    end
  end
end
