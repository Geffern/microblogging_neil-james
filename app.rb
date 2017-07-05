require 'sinatra'

before do 
	@class_name="default"
end


get '/' do
	@class_name="home"	
	erb :home
end

get '/sign_in' do
 	@class_name="sign_in"	
 	erb :sign_in
end

# get '/about' do
# 	@class_name="about"	
# 	erb :about
# end

# get '/contact' do
# 	@class_name="contact"	
# 	erb :contact
# end