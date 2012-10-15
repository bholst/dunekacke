class CreateTunes < ActiveRecord::Migration
  def change
    create_table :tunes do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    
    add_index :tunes, [:user_id, :created_at]
  end
end
