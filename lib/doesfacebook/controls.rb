# AWEXOME LABS
# DoesFacebook
#
# Controls - convenience methods for injection into controllers

module DoesFacebook
  module Controls
    
    # Exception Classes:
    class MalformedUrlOptions < Exception; end
    
    
    protected
    
    # Mechanism for redirecting within the Facebook canvas:
    def redirect_to_canvas(opts={})
      raise MalformedUrlOptions.new("Options passed to `redirect_to_canvas` must be a URL options Hash") unless opts.is_a?(Hash)
      dest = File.join("http://apps.facebook.com/", facebook_config[:canvas_name], url_for(opts.merge(:only_path=>true))) 
      logger.info "Canvas Redirect to #{opts.inspect}=>#{dest}"
      redirect_to dest
    end
    
  end # Controls
end # DoesFacebook
