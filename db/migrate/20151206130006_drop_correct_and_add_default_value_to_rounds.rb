class DropCorrectAndAddDefaultValueToRounds < ActiveRecord::Migration
  def change
    remove_column :rounds, :correct
    remove_column :rounds, :attempt
    add_column :rounds, :attempt, :integer, default: 0
  end
end
