require 'sinatra'
require './models/post'

get "/" do
  "Hello world!"
end

get "/health_check" do
  "ok"
end


