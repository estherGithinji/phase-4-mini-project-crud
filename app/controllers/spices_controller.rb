class SpicesController < ApplicationController
    # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: 201
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: 200
    rescue ActiveRecord::RecordNotFound
        render_not_found_response    
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render_not_found_response    
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        spice = Spice.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: 404
    end
end
