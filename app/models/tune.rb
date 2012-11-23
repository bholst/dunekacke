class Tune < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :content, :presence => true
  
  before_save :create_rendering
  before_destroy :delete_rendering
  
  private
    def create_rendering
      directory = "#{Rails.root}/tmp/abc/"
      filebase = "#{directory}abc_"+rand(10000).to_s
      abc_filename = filebase + ".abc"
      ps_filename = filebase + ".ps"
      rendering_directory = "#{Rails.root}/data/renderings/"
      png_filename = rendering_directory       +
                     Time.now.getutc.to_i.to_s +
                     rand(100000).to_s         +
                     ".png"
      
      begin
        Dir::mkdir(directory)
      rescue
        puts "the " + directory + " directory already exists"
      end
      
      begin
        Dir::mkdir("#{Rails.root}/data")
      rescue
        puts "the " + "#{Rails.root}/data" + " directory already exists"
      end
      
      begin
        Dir::mkdir(rendering_directory)
      rescue
        puts "the " + rendering_directory + " directory already exists"
      end
      
      abc = File.open(abc_filename, "w") do |file|
        file.puts(content)
      end
      
      system("abcm2ps #{abc_filename} -O #{ps_filename}")
      system("convert -trim #{ps_filename} #{png_filename}")
      
      File.delete(abc_filename)
      File.delete(ps_filename)
      if(rendering_file_name)
        File.delete(read_attribute(:rendering_file_name))
      end
      write_attribute(:rendering_file_name, png_filename)
      write_attribute(:rendering_content_type, "image/png")
      write_attribute(:rendering_file_size, File.size(png_filename))
    end
    
    def delete_rendering
      File.delete(rendering_file_name)
    end
end
