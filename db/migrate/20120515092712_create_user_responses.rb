class CreateUserResponses < ActiveRecord::Migration
  def change
    create_table :user_responses do |t|
      t.string :value
      t.references :question
      t.references :user
      t.references :form
      t.timestamps
    end
  end
end
