# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Return the current application id to the view
  def app_id
    controller.send(:facebook_config)[:app_id]
  end
  
  # Return the current app namespace:
  def app_namespace
    controller.send(:facebook_config)[:namespace]
  end
  
  # Return the full canvas URL:
  def app_canvas_url
    "#{request.ssl? ? "https://" : "http://"}apps.facebook.com/#{app_namespace}"
  end
  
  # Generate a URL that points within the Facebook canvas
  def url_for_canvas(url_opts={})
    controller.send(:url_for_canvas, url_opts)
  end

  # Generate a link that points within the Facebook canvas
  def link_to_canvas(text, url_opts={}, html_opts={})
    content_tag("a", text, html_opts.merge(:rev=>"canvas", :href=>url_for_canvas(url_opts), :target=>"_top"), false)
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
