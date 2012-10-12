# AWEXOME LABS
# DoesFacebook Configuration File
#
# Use this initializer to declare logical Facebook applications your
# Rails app will harness. 
#
# You can specify any number of applications statically, from a dynamic
# source such as your database, or from elsewhere.
#

DoesFacebook.configure do |config|

  # Add each Facebook Application (defined in your Developer Dashboard
  # at developers.facebook.com) here, like so:
  config.add_application(
    id: 123456789012345,
    secret: "abcdefghijklmnopqrstuvwxyzABCDEF"
    namespace: "your_app_namespace",
    canvas_url: "http://your.dev.server.com/and/path",
    secure_canvas_url: "https://secure.dev.server"
  )

  # You may specify the method by which DoesFacebook selects the app
  # configuration for each request with a lambda or Proc. This example 
  # uses canvas_url, but you can make this distinction however you wish:
  # config.app_selector = Proc.new() do |request, apps|
  #   apps.find do |a|
  #     callback_path = request.ssl? && a.supports_ssl? ? a.secure_canvas_url : a.canvas_url
  #     request.url.match(/^#{callback_path}.*/)
  #   end
  # end

end
