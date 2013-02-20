class TuneRating < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :user
  belongs_to :tune
  
  validates :tune_id, :presence => true
  validates :user_id, :presence => true
  validates_numericality_of :value, :only_integer => true,
      :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 5
  validates_uniqueness_of :user_id, :scope => :tune_id
end
