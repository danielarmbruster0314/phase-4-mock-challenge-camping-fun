class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :non_creatable
    def create 
        signup = Signup.create!(create_params)
        render json: signup.activity, status: :created 
    end 

    private 

    def create_params
        params.permit(:camper_id, :activity_id, :time)
    end 

    def non_creatable exception
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end 
end
