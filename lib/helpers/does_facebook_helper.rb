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
  

  # Insert properly-formed FB.init() call with fb-root doc element. Yields a block which
  # can be used to inject further FB initialization JavaScript within fbAsyncInit
  def fb_init(init_opts={}, &block)
    init_opts = {appId: app_id, channelUrl: "/channel.html", status: true, cookie: true, xfbml: false}.merge(init_opts)
    injection = """<!-- Facebook JS SDK -->
    <div id=\"fb-root\"></div>
    <script>
      window.fbAsyncInit = function() {
        FB.init(#{init_opts.to_json});"""
    injection += capture(&block) if block_given?
    injection += """
      };
      (function(d){
         var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement('script'); js.id = id; js.async = true;
         js.src = \"//connect.facebook.net/en_US/all.js\";
         ref.parentNode.insertBefore(js, ref);
       }(document));
    </script>"""
    return injection.html_safe
  end
  
  
end
