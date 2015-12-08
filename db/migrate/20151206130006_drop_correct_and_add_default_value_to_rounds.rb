class DropCorrectAndAddDefaultValueToRounds < ActiveRecord::Migration
  def change
    remove_column :rounds, :correct
    remove_column :rounds, :attempt
    add_column :rounds, :attempt, :integer, default: 0
    # The "attempt" value, is actually something that you can infer
    # from looking at the guesses made on a round.
  end
end
