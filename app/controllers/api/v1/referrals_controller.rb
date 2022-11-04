# frozen_string_literal: true

module Api
  module V1
    # Referrals controller
    class ReferralsController < ApplicationController
      before_action :set_referral, only: %i[show update destroy]

      # GET api/v1/referrals
      def index
        @referrals = Referral.where(params.permit(:referrer_id, :referee_id))

        render json: @referrals
      end

      # GET api/v1/referrals/1
      def show
        render json: @referral
      end

      # POST api/v1/referrals
      def create
        @referral = Referral.new(referral_params)

        if @referral.save
          render json: @referral, status: :created, location: @referral
        else
          render json: @referral.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT api/v1/referrals/1
      def update
        if @referral.update(referral_params)
          render json: @referral
        else
          render json: @referral.errors, status: :unprocessable_entity
        end
      end

      # DELETE api/v1/referrals/1
      def destroy
        @referral.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_referral
        @referral = Referral.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def referral_params
        params.require(:referral).permit(:referrer_id, :referee_id, :completed_at)
      end
    end
  end
end
