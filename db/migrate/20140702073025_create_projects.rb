class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :Year
      t.string :Week
      t.string :Team
      t.string :Opponent
      t.string :Name
      t.string :Position
      t.integer :PassingYards
      t.integer :PassingTouchdowns
      t.integer :PassingInterceptions
      t.integer :RushingYards
      t.integer :RushingTouchdowns
      t.integer :Receptions
      t.integer :ReceivingYards
      t.integer :ReceivingTouchdowns
      t.integer :FumblesLost
      t.timestamps
    end
  end
end
