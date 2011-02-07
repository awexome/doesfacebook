# AWEXOME LABS
# DoesFacebook
#
# Helpers - view helpers

module DoesFacebook
  module Helpers
    
    # Generate a URL that points within the Facebook canvas
    def url_for_canvas(url_opts={})
      canvas_root = File.join("http://apps.facebook.com", facebook_config[:canvas_name])
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
      link_to(text, url_for_canavs(url_opts), html_opts.merge(:target=>"_top"))
    end
    
  end # Helpers
end # DoesFacebook
