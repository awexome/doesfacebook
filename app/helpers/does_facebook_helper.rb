# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Generate a URL that points within the Facebook canvas
  def url_for_canvas(url_opts={})
    canvas_name = controller.send(:facebook_config)["canvas_name"]
    canvas_root = File.join("http://apps.facebook.com", canvas_name)
    if url_opts.is_a?(Hash)
      return File.join(canvas_root, url_for(url_opts))
    elsif url_opts.include?("://")
      return url_opts
    else
      return File.join(canvas_root, url_opts)
    end
  end

  # Generate a link that stays within the Facebook canvas
  def link_to_canvas(text, url_opts={}, html_opts={})
    url = url_for_canvas(url_opts)
    content_tag("a", text, html_opts.merge(:rel=>"canvas", :href=>url, :target=>"_top"), false)
  end
  
end
