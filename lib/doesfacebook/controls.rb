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
    def redirect_to_canvas_old(opts={})
      raise MalformedUrlOptions.new("Options passed to `redirect_to_canvas` must be a URL options Hash") unless opts.is_a?(Hash)
      dest = File.join("http://apps.facebook.com/", facebook_config[:canvas_name], url_for(opts.merge(:only_path=>true))) 
      logger.info "Canvas Redirect to #{opts.inspect}=>#{dest}"
      redirect_to dest
    end
    
    # Purer, JavaScript-based solution for redirecting within the Facebook canvas:
    def redirect_to_canvas(opts={})
      raise MalformedUrlOptions.new("Options passed to `redirect_to_canvas` must be a URL options Hash") unless opts.is_a?(Hash)
      dest = File.join("http://apps.facebook.com/", facebook_config[:canvas_name], url_for(opts.merge(:only_path=>true))) 
      @facebook_redirect_url = dest
      logger.info "Canvas Redirect to #{opts.inspect}=>#{dest}"
      begin
        render :partial=>"facebook/redirect"
      rescue ActionView::MissingTemplate=>e
        logger.info "Pretty Redirect Partial facebook/redirect Not Found. Using Unformatted Text."
        render :text=>%{
          Redirecting you to <a href="#{dest}">#{dest}</a>...
          <script type="text/javascript">
            top.location.href = "#{dest}";
          </script>
        }
      end
    end
    
  end # Controls
end # DoesFacebook
