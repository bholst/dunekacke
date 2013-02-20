class Tune < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  has_many :tune_ratings
  has_many :raters, :through => :ratings, :source => :users
  
  validates :user_id, :presence => true
  validates :content, :presence => true
  
  before_save :check_fields
  
  def check_fields
    add_fields()
  end
  
  def add_fields(args = {"X" => "1"})
    result = ""
    found = Set.new
    whitespace = ""
    
    self.content.each_line do |line|
      matchdata = line.match(/^\s*([A-GX-Z]):(\s*)(\S.*)\n$/)
      
      if matchdata
        found.add(matchdata[1])
        whitespace = matchdata[2]
      end
      
      result += line
    end
    
    if not found.include?("X")
      result = "X:" + whitespace + args["X"] + "\n" + result
    end
    
    self.content = result
  end
end
