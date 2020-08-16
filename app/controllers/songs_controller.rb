require 'rack-flash'

class SongsController < ApplicationController

    use Rack::Flash

    get '/songs' do 
        @songs = Song.all 
        erb :"songs/index"
    end

    get '/songs/new' do
        @songs = Song.all
        @genres = Genre.all
        erb :"songs/new"
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end

    post '/songs' do 
        song = Song.create(name: params[:song][:name])
        song.artist = Artist.find_or_create_by(name: params[:song][:artist])
        song.genres << Genre.find(params[:song][:genre_ids])
        song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :"songs/edit"
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        song.update(name: params[:song][:name])
        song.artist = Artist.find_or_create_by(name: params[:song][:artist])
        song.genres << Genre.find(params[:song][:genre_ids])
        song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{song.slug}"
    end

end
