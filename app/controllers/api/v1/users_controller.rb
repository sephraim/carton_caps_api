class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy referrer referees ]

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

    if @user.save
      render json: @user, status: :created, location: @user
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
    @referees = @user.referees

    render json: @referees, include: [:referee]
  end

  # GET api/v1/users/1/referrer
  def referrer
    @referrer = @user.referrer

    render json: @referrer, include: [:referrer]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthdate, :zip_code, :referral_code)
  end
end
