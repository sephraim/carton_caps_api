# frozen_string_literal: true

module Api
  module V1
    # Users controller
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy referrer referees]

      # GET api/v1/users
      def index
        @users = User.all

        render json: @users
      end

      # GET api/v1/users/1
      def show
        render json: @user
      end

      # POST api/v1/users
      def create
        @user = User.new(user_params)

        if params.include?(:referral_code_used)
          create_user_with_referral_code
        elsif @user.save
          render json: @user, status: :created, location: api_v1_user_path(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT api/v1/users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE api/v1/users/1
      def destroy
        @user.destroy
      end

      # GET api/v1/users/1/referees
      def referees
        render json: @user, serializer: Api::V1::UserAsReferrerSerializer
      end

      # GET api/v1/users/1/referrer
      def referrer
        render json: @user, serializer: Api::V1::UserAsRefereeSerializer
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :birthdate, :zip_code)
      end

      # Validate referral code
      #
      # @return [Boolean] true if referral code is valid; else false
      def valid_referral_code?
        @referral_code_used = params[:referral_code_used]
        @referrer = User.find_by(referral_code: @referral_code_used)
        @referrer.present?
      end

      # Create a new referral record if user used a valid referral code
      def create_referral
        Referral.create(referrer_id: @referrer.id, referee_id: @user.id) if @referrer.present?
      end

      # Create user with referral code
      def create_user_with_referral_code
        if valid_referral_code?
          if @user.save
            # User created successfully (valid referral code used)
            create_referral
            render json: @user, status: :created, location: api_v1_user_path(@user)
          else
            # User creation failed
            render json: @user.errors, status: :unprocessable_entity
          end
        else
          # User creation failed because referral code does not exist
          msg = { message: 'Referral code does not exist.' }
          render json: msg, status: :unprocessable_entity
        end
      end
    end
  end
end
