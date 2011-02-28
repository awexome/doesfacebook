# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Return the current application id to the view
  def app_id
    controller.send(:facebook_config)[:app_id]
  end
  
  # Return the API key of the current application to the view
  def api_key
    controller.send(:facebook_config)[:api_key]
  end
  
  # Return the current app callback URL
  def app_callback_url
    controller.send(:facebook_config)[:callback_url]
  end
  
  # Return the current app canvas name:
  def app_canvas_name
    controller.send(:facebook_config)[:canvas_name]
  end
  
  # Return the full canvas URL:
  def app_canvas_url
    "http://apps.facebook.com/#{app_canvas_name}"
  end
  
  # Generate a URL that points within the Facebook canvas
  def url_for_canvas(url_opts={})
    canvas_root = File.join("http://apps.facebook.com", app_canvas_name)
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
    content_tag("a", text, html_opts.merge(:rev=>"canvas", :href=>url, :target=>"_top"), false)
  end
  
end
