class CreateTuneRatings < ActiveRecord::Migration
  def change
    create_table :tune_ratings do |t|
      t.integer :user_id
      t.integer :tune_id
      t.integer :value

      t.timestamps
    end
  end
end
