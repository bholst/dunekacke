module TunesHelper
  # Returns the Title of a given tune
  def title_of(tune)
    match = /^T:(.+)$/.match(tune.content)
    title = ""
    
    if match != nil
        title = match[1]
    end
    
    title
  end
  
  def content_as_string(tune)
      content = tune.content
      content = content.gsub(/\n|\r\n|\r/, "\\n")
      content = content.gsub(/"/, "\\\"")
  end
end
