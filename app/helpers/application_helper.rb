module ApplicationHelper
  include TimeConversion 
  
  def title(page_name)
    content_for(:title) { page_name }
  end

  def image_tag_link(image_path, target_link, options={})
    link_to(image_tag(image_path, options), target_link)
  end

end
