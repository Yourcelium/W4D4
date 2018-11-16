class AlbumsController < ApplicationController
    before_action :require_login
    
    def new
      @band = Band.find(params[:band_id])

      if @band 
        @album = Album.new(band_id: @band.id)
        render :new
      else
        flash[:messages] = ["Invalid Band"]
        bands_url
      end
    end

    def show
        @album = Album.find(params[:id])
        @band = Band.find(@album.band_id)
        if @album      
            render :show
        else
            flash[errors] = @band.errors.full_messages
            redirect_to bands_url
        end
    end

    def create
        @album = Album.new(album_params)
        @band = Band.find(params[:album][:band_id])
        debugger
        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end
    end

    def edit
        @album = Album.find(params[:id])
        if @album
            render :edit
        else
            flash.now[:errors] = @album.errors.full_messages
            flash.now[:errors].unshift("That album doesn't exist dummy")
            render :new
        end
    end

    def update
        @album = Album.find(params[:id])

        if @album.update_attributes(album_params)
        redirect_to album_url(@album)
        else
        flash.now[:errors] = @album.errors.full_messages
        render :edit
        end
    end

    def destroy
        @album = Album.find(params[:id])
        
        if @album
            @album.destroy
            redirect_to bands_url
        else
            flash[errors] = @band.errors.full_messages
            redirect_to bands_url
        end
    end

    private
    def album_params
        params.require(:album).permit(:band_id, :title, :yr, :live)
    end
end