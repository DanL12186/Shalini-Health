module ApplicationHelper
  include TimeConversion 
  
  def title(page_name)
    content_for(:title) { page_name }
  end

  def random_image
    image_tag "https://picsum.photos/id/#{rand(1000)}/300/300"
  end

end
