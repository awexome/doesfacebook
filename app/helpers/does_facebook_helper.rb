# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Return the current application id to the view
  def app_id
    controller.send(:facebook_config)[:app_id]
  end
  
  # Return the current app callback URL
  def app_callback_url
    if request.ssl?
      controller.send(:facebook_config)[:ssl_callback_url] || controller.send(:facebook_config)[:callback_url]
    else
      controller.send(:facebook_config)[:callback_url]
    end
  end
  
  # Return the current app namespace:
  def app_namespace
    controller.send(:facebook_config)[:namespace]
  end
  alias_method :app_canvas_name, :app_namespace     # <= Deprecation of "canvas_name", but still aliased
  
  # Return the full canvas URL:
  def app_canvas_url
    "#{request.ssl? ? "https://" : "http://"}apps.facebook.com/#{app_namespace}"
  end
  
  # Generate a URL that points within the Facebook canvas
  def url_for_canvas(url_opts={})
    canvas_root = app_canvas_url
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
  
  # Insert properly-formed FB.init() call with fb-root doc element
  def fb_init(opts={})
    opts = {:status=>true, :cookie=>true, :xfbml=>true}.merge(opts)
    opts.merge!(:appId=>app_id)
    raw("""<div id=\"fb-root\"></div>
    <script src=\"http://connect.facebook.net/en_US/all.js\"></script>
    <script>
      FB.init(#{opts.to_json});
      window.fbAsyncInit = function() {
        FB.XFBML.parse();
        FB.Canvas.setAutoGrow();
      }
    </script>
    """)
  end
  
  
end
