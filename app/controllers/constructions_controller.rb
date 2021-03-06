class ConstructionsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if params[:line_id]
      line = Line.find(params[:line_id])
      @constructions = line.constructions
    elsif params[:station] && params[:station] != ""
      @constructions = Construction.search(params[:station])
    else
      @constructions = Construction.all
    end
    @construction = Construction.new

    respond_to(:html, :js)
  end

  def new
    @construction = Construction.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @construction = current_user.constructions.new(construction_params)
    respond_to do |format|
      if @construction.save
        format.html do
          flash[:notice] = 'New construction added successfully.'
          redirect_to constructions_path
        end
        format.js do
          @constructions = Construction.all
          render :index
        end
      else
        format.html do
          flash[:alert] = @construction.errors.full_messages.join(', ')
          render :new
        end
        format.js do
          @errors = @construction.errors.full_messages.join(', ')
        end
      end
    end
  end

  def edit
    construction = Construction.find(params[:id])
    if signed_in? && current_user == construction.user
      @construction = construction
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to edit this posting'
      redirect_to constructions_path
    end
  end

  def update
    @construction = Construction.find(params[:id])
    if @construction.update_attributes(construction_params)
      flash[:notice] = 'Construction updated successfully.'
      redirect_to constructions_path
    else
      flash[:alert] = @construction.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    construction = Construction.find(params[:id])
    if signed_in? && current_user == construction.user
      construction.destroy
      flash[:notice] = 'Construction deleted successfully.'
      redirect_to constructions_path
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to edit this posting'
      redirect_to constructions_path
    end
  end

  private

  def construction_params
    params.require(:construction).permit(:line_id,
      :start_station_id, :end_station_id, :start_date, :end_date,
      :start_time, :end_time, :description)
  end
end
