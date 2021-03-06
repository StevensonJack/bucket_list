class ActivitiesController < ApplicationController
  before_action :find_activity, only: [:show, :edit, :update, :destroy]
  before_action :find_bucket, only: [:show, :edit, :update, :index, :new, :create]

  def index
    @activities = @bucket.activities.order(rating: :asc) 
    @markers = @activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude
      }
    end
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.title.capitalize!
    @activity.bucket = @bucket
    @activity.photo = select_photo.urls.regular
    if @activity.save
      flash[:success] = "Activity successfully created"
      redirect_to bucket_activity_path(@bucket, @activity)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def show
    @offers = @activity.offers.limit(3)
  end

  def edit
  end

  def update
    @activity.title.capitalize!
    if @activity.update(activity_params)
      flash[:success] = "Activity was successfully updated"
      redirect_to bucket_activity_path(@bucket)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @activity.destroy
      flash[:success] = 'Activity was successfully deleted.'
      redirect_to bucket_activities_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to bucket_activities_path
    end
  end

  private

  def find_activity
    @activity = Activity.find(params[:id])
  end

  def find_bucket
    @bucket = Bucket.find(params[:bucket_id])
  end

  def activity_params
    params.require(:activity).permit(:title, :budget, :location, :time_frame, :people_number, :category, :photo)
  end

  def select_photo
    photo = nil

    while photo.nil?
      photo = Unsplash::Photo.search("#{@activity.location}", orientation = "landscape")[rand(1..30)]
    end

    return photo
  end
end
