# AWEXOME LABS
# DoesFacebook
#
# DoesFacebookHelper - add helpers to 

module DoesFacebookHelper
  
  # Return a reference to the current Facebook Application config:
  def fb_app
    @fb_app
  end

  # Return the current application id to the view
  def app_id
    fb_app.id
  end
  
  # Return the current app namespace:
  def app_namespace
    fb_app.namespace
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

  # Display a user's Facebook profile photo
  def profile_pic(facebook_id, opts={})
    type = opts.delete(:type) || "square" # <= Valid types: square, small, normal, large
    opts = {:class=>"profile-pic", :border=>0}.merge(opts)
    image_tag("//graph.facebook.com/#{facebook_id}/picture?type=#{type}", opts)
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
