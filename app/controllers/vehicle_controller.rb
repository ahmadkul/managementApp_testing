class VehicleController < ApplicationController

  def view
    if current_user.role == 'admin'
      @user_id = params[:id]
    else
      @user_id = current_user.id
    end
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params.merge!(user_id: current_user.id))

    if @vehicle.save
      redirect_to :action => 'view'
    else
      render :action => 'new'
    end
  end

  # helper function for fetching Vehicle data from "new" form
  def vehicle_params
    params.require(:vehicle).permit(:license, :colour, :make, :model, :year, :user_id)
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])

    if @vehicle.update_attributes(vehicle_param)
      redirect_to :action => 'view', :id => @vehicle.user_id
    else
      render :action => 'edit'
    end
  end

  # helper function for fetching Vehicle data from "edit" form
  def vehicle_param
    params.require(:vehicle).permit(:license, :colour, :make, :model, :year)
  end

  def delete
    Vehicle.find(params[:id]).destroy
    redirect_to :action => 'view', :id => params[:user_id]
  end

  def pay
    Vehicle.where(:id => params[:id]).update_all(:paid => "Paid")
    redirect_to :action => 'view', :id => params[:user_id]
  end
end
