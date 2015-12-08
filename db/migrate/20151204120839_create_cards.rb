class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :deck_id, null: false # If the object cannot exist without this value, make sure it is not able to be null
      t.string :question, null: false
      t.string :answer, null: false

     t.timestamps null: false
    end
  end
end
