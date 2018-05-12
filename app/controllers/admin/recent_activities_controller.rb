# @abstract an admin namespace controller for handling recent activities
class Admin::RecentActivitiesController < ApplicationController
  before_action :authenticate_admin!

  # GET /admin/recent_activities
  def index
    find_recent_activities
  end

  # GET /admin/recent_activities/1
  def show
    find_recent_activity
  end

  # GET /admin/recent_activities/new
  def new
    build_recent_activity
  end

  # GET /admin/recent_activities/edit/1
  def edit
    find_recent_activity
  end

  # POST /admin/recent_activities
  def create
    build_recent_activity
    if persist_recent_activity
      redirect_to admin_recent_activity_path(@recent_activity)
    else
      render :new
    end
  end

  # PUT   /admin/recent_activities/1
  # PATCH /admin/recent_activities/1
  def update
    find_recent_activity
    if persist_recent_activity
      redirect_to admin_recent_activity_path(@recent_activity)
    else
      render :edit
    end
  end

  # DELETE /admin/recent_activities/1
  def destroy
    find_recent_activity
    @recent_activity.destroy
    redirect_to admin_recent_activities_path
  end

  private

  # Creates a list of all recent activity models.
  #
  # @return [void]
  def find_recent_activities
    @recent_activities = RecentActivity.all
  end

  # Finds a RecentActivity record using an id and instantiates it.
  #
  # @return [void]
  def find_recent_activity
    @recent_activity = InitializeRecentActivity.call id: params[:id]
  end

  # Builds a new instance of RecentActivity
  #
  # @return [void]
  def build_recent_activity
    @recent_activity = BuildRecentActivity.call
  end

  # Persists an instance of RecentActivity to the database using the parameters
  #   sent from the client.
  #
  # @return [true] if successfully saved.
  # @return [false] if the save was unsuccessful
  def persist_recent_activity
    PersistRecentActivity.call(recent_activity: @recent_activity,
                               params: recent_activity_params)
  end

  # Filters the parameters sent with a whitelist using StrongParameters.
  #
  # @return [ActionController::Parameters]
  def recent_activity_params
    FilterRecentActivityParams.call params: params
  end
end
