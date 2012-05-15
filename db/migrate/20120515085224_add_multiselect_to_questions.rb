class AddMultiselectToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :multiselect, :boolean
  end
end
