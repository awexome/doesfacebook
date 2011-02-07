# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Generate a URL that points within the Facebook canvas
  def url_for_canvas(url_opts={})
    controller.send(:canvas_url_for, options)
  end
  
  # Generate a link that stays within the Facebook canvas
  def link_to_canvas(text, url_opts={}, html_opts={})
    controller.send(:link_to_canvas, text, url_opts, html_opts)
  end
  
end
