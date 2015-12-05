class CreateColumnCorrectInGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :correct?, :boolean, default: false
  end
end
