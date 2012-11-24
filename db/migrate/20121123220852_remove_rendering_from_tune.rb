class RemoveRenderingFromTune < ActiveRecord::Migration
  def self.up
    remove_column :tunes, :rendering_file_name
    remove_column :tunes, :rendering_content_type
    remove_column :tunes, :rendering_file_size
  end
  
  def self.down
    add_column :tunes, :rendering_file_name, :string
    add_column :tunes, :rendering_content_type, :string
    add_column :tunes, :rendering_file_size, :integer
  end
end
