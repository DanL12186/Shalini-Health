module ApplicationHelper
  include TimeConversion 
  
  def title(page_name)
    content_for(:title) { page_name }
  end

end
