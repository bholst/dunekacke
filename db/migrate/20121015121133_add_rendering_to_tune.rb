class AddRenderingToTune < ActiveRecord::Migration
  def self.up
    add_column :tunes, :rendering_file_name, :string
    add_column :tunes, :rendering_content_type, :string
    add_column :tunes, :rendering_file_size, :integer
  end
  
  def self.down
    remove_column :tunes, :rendering_file_name
    remove_column :tunes, :rendering_content_type
    remove_column :tunes, :rendering_file_size
  end
end
