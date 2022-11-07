# frozen_string_literal: true

module Api
  module V1
    # Users controller
    class UsersController < ApplicationController
      MAX_NUM_REFERRALS = 10
      private_constant :MAX_NUM_REFERRALS

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

        if body_params.include?(:referral_code_used)
          create_user_with_referral_code
        else
          create_user_without_referral_code
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
        render json: @user.destroy, status: :no_content
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

      # Use callbacks to share common setup or constraints between actions
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted user parameters through
      def user_params
        params.permit(:first_name, :last_name, :birthdate, :zip_code)
      end

      # Only allow a list of other trusted body parameters through
      def body_params
        params.permit(:first_name, :last_name, :birthdate, :zip_code, :referral_code_used)
      end

      # Validate referral code
      #
      # @return [Boolean] true if referral code is valid; else false
      def valid_referral_code?
        @referral_code_used = body_params[:referral_code_used]
        @referrer = User.find_by(referral_code: @referral_code_used)
        if @referrer.blank?
          @error_msg = 'Referral code does not exist'
          return false
        elsif Referral.where(referrer_id: @referrer.id).count >= MAX_NUM_REFERRALS
          @error_msg = 'User has already reached maximum number of referrals'
          return false
        end
        true
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
          status = :unprocessable_entity
          render json: error(status:, exception: @error_msg), status:
        end
      end

      # Create user without referral code
      def create_user_without_referral_code
        if @user.save
          render json: @user, status: :created, location: api_v1_user_path(@user)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # Create error hash
      #
      # @param status [Symbol] HTTP status code symbol from Rack::Utils::SYMBOL_TO_STATUS_CODE.keys
      #   e.g. :unprocessable_entity
      # @param exception [String] Error message
      # @return [Hash] Hash that will be rendered in the JSON output
      def error(status:, exception:)
        status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
        {
          status: status_code,
          error: Rack::Utils::HTTP_STATUS_CODES[status_code],
          exception:
        }
      end
    end
  end
end
