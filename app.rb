require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @bookmarks = Bookmark.all
    erb(:index)
  end

  get '/add' do
    erb(:add)
  end

  post '/add' do
    if params[:bookmark] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.add(params[:bookmark], params[:title])
      redirect('/')
    else
      flash[:error] = "Invalid url"
      redirect('/add')
    end
  end

  run! if app_file == $0

end
