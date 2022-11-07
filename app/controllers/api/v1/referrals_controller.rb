# frozen_string_literal: true

module Api
  module V1
    # Referrals controller
    class ReferralsController < ApplicationController
      before_action :set_referral, only: %i[show update destroy]

      # GET api/v1/referrals
      def index
        @referrals = Referral.where(query_params)

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
          render json: @referral, status: :created, location: api_v1_referral_path(@referral)
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

      # Use callbacks to share common setup or constraints between actions
      def set_referral
        @referral = Referral.find(params[:id])
      end

      # Only allow a list of trusted referral parameters through
      def referral_params
        params.require(:referral).permit(:referrer_id, :referee_id, :completed_at)
      end

      # Only allow a list of trusted query parameters through
      def query_params
        params.permit(:referrer_id, :referee_id)
      end
    end
  end
end
