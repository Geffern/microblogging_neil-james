require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require 'sinatra/flash'
set :database, {adapter: 'sqlite3', database: 'db/microblog.db'}
enable :sessions
require './models'
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

post '/sign_in' do
	@user = User.find_by(email: params[:email])
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:message] = "Welcome to our site, #{@user.uname}"
		redirect '/profile'
	else
		flash[:message]="We don't recognize that information. Sorry!"
	end
end


before do
	@current_user = session[:user_id] ? User.find(session[:user_id]) : nil
	# @current_user = User.find(session[:user_id])
end

before ['/author', '/profile'] do 
	redirect '/' unless @current_user
end

get '/author' do
	@class_name="author"
	erb :author
	end

post '/author' do
	@post = Post.new( title: params[:title],
		body: params[:body],
		user_id: @current_user.id)
	if @post.save
		flash[:message] = "Got your post! Nice Work!"
		redirect '/profile'
		else
			flash[:message] = "Unable to save your post"
			redirect '/author'
		end
end

get '/profile' do
	@class_name="profile"
 	erb :profile
end

get '/user/:id' do
	@class_name="user"
	@user = User.find(params[:id])
	erb :user
end

get '/post/:id' do
	@class_name="post"
	@post = Post.find(params[:id])
erb :post
	end
post '/profile' do
	if @current_user.password == params[:password]
		User.update(
			uname: params[:uname]
			)
		flash[:message] = "Never too late too late to reinvent yourself!"
	else
		flash[:message]= "Looks like you gave us the wrong password. Hack denyied!!"
end
redirect '/profile'
end

post '/user' do
	@user = User.new( uname: params[:uname],
		email: params[:email], password: params[:password] )
	if @user.save
		flash[:message] = "Thanks for joining!"
		session[:user_id]=@user.id
		redirect '/profile'
		else
			flash[:message] = "Sorry! Something Bad Happened."
			redirect '/'
		end
end

get '/sign_out' do
    session[:user_id] = nil
    redirect '/'
end

get '/deleteAccount' do
@current_user.posts.destroy_all
@current_user.destroy

session[:user_id] = nil
redirect '/'
end

# get '/about' do
# 	@class_name="about"	
# 	erb :about
# end

# get '/contact' do
# 	@class_name="contact"	
# 	erb :contact
# end