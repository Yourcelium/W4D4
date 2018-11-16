class BandsController < ApplicationController
    before_action :require_login
    
    def index
      @bands = Band.all

      render :index
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            redirect_to bands_url(@band)
        else
            flash[errors] = @band.errors.full_messages
            redirect_to new_bands_url
        end
    end

    def new
        @band = Band.new

        render :new
    end

    def edit
        @band = Band.find(params[:id])

        if @band
            render :edit
        else
            flash[errors] = @band.errors.full_messages
            redirect_to bands_url(band)
        end
    end

    def update
        @band = Band.find(params[:id])
        
        if @band.update_attributes(band_params)
            redirect_to bands_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :edit
        end
    end
    
    def show
        @band = Band.find(:id)

        if @band
            render :show
        else
            flash[errors] = @band.errors.full_messages
            redirect_to bands_url
        end
      
    end

    def destroy
        @band = Band.find(:id)

        if @band
            @band.destroy
            flash[:messages] = ["#{@band.name} removed from database"]
            redirect_to bands_url
        else
            flash[errors] = @band.errors.full_messages
            redirect_to bands_url
        end
      
    end


    private
    def band_params
        params.require(:band).permit(:name)
    end
end