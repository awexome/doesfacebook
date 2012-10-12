# AWEXOME LABS
# DoesFacebook
#
# ControllerExtensions - convenience methods and filters injected into controllers
#  which enact DoesFacebook
#

module DoesFacebook
  module ControllerExtensions
    
    protected

    def fb_app
      DoesFacebook.configuration.applications.first
    end

    def url_for_canvas(opts={})
      canvas_root = if request.ssl? && fb_app.supports_ssl?
        "https://apps.facebook.com/#{fb_app.namespace}/"
      else
        "http://apps.facebook.com/#{fb_app.namespace}/"
      end
      case opts
        when String
          opts =~ /:\/\// ? opts : File.join(canvas_root, opts)
        when Hash
          opts.merge(:only_path=>true)
          File.join(canvas_root, url_for(opts))
      end
    end

    def redirect_to_canvas(opts={})
      @facebook_redirect_url = url_for_canvas(opts)
      Rails.logger.info "Canvas Redirect to #{@facebook_redirect_url}"
      begin
        render :partial=>"facebook/redirect"
      rescue ActionView::MissingTemplate => e
        logger.info "Pretty Redirect Partial facebook/redirect Not Found. Using Unformatted Text."
        render :text=>%{
          Redirecting you to <a href="#{@facebook_redirect_url}">#{@facebook_redirect_url}</a>...
          <script type="text/javascript"> top.location.href = "#{@facebook_redirect_url}"; </script>
        }.html_safe
      end
    end
    
  end # ControllerExtensions
end # DoesFacebook
