class SlotsController < ApplicationController
  
  def index
    @slot = Slot.new
    @remove_buttons = true
    @user = current_user
  end
  
  def create
    @slot = Slot.new(slot_params)
    @slot.user_id = current_user.id
    if @slot.save
      flash[:notice] = "Your slot was added"
      redirect_to slots_path
    else
      render :index
    end
  end
  
  def destroy
    slot = Slot.find(params[:id])
    slot.destroy
    flash[:notice] = "Slot has been removed"
    redirect_to :back
  end
  
  private
  
  def slot_params
    params.require(:slot).permit(:label, :start_time, :end_time, :day)
  end
  
end