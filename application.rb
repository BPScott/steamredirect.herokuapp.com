require 'sinatra/base'

#Reloader
require './lib/sinatra-reloader'


class Application < Sinatra::Base
  #TODO Add Caching for requests
  configure do
    set :app_file, __FILE__
  end

  configure :development do
    use Sinatra::Reloader
  end

  get '/?' do
    require 'rdiscount'
    
    headers['Cache-Control'] = 'public, max-age=600'
    markdown :'../readme', :layout_engine => :erb
  end
  
  get %r{/(.+)} do |path|
    headers['Cache-Control'] = 'public, max-age=1314000' #1 year
    redirect 'steam://' + path, 301
  end
end