class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_uncreatable_entity
    def index 
        campers = Camper.all 
        render json: campers
    end 

    def show 
        camper = find_by
        render json: camper, serializer: CamperWithActivitiesSerializer
    end 


    def create 
        camper = Camper.create!(camp_params)
        render json: camper, status: :created
    end 



    private 

    def find_by
        Camper.find(params[:id])
    end 

    def render_not_found 
        render json: { error: "Camper not found" }, status: :not_found 
    end 

    def render_uncreatable_entity(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end 

    def camp_params
        params.permit(:name, :age)
    end 
end
