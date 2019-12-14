class AdminController < ApplicationController

  # before_action :authenticate_user!, except: [:home]
  skip_before_action :authenticate_user!

  def home
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_param)
      redirect_to :action => 'home'
    else
      render :action => 'edit_user'
    end
  end

  # helper function for fetching User data from "edit_user" form
  def user_param
    params.require(:user).permit(:fName,:lName,:email,:password,:address ,:password_confirmation, :pCode, :city, :role, :telephone, :province)
  end

  def delete
    @vehicles = Vehicle.where(user_id: params[:id])
    @vehicles.each do |v|
      v.destroy
    end

    User.find(params[:id]).destroy
    redirect_to :action => 'home'
  end

end
