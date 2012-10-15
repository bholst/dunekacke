module TunesHelper
  # Returns the Title of a given tune
  def title_of(tune)
    /^T:(.+)$/.match(tune.content)[1]
  end
end
