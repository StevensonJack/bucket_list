class BucketsController < ApplicationController
  before_action :find_bucket, only: [:show, :destroy]

  def index
    @buckets = Bucket.all
    @bucket = Bucket.new
  end

  def create
    @buckets = Bucket.all
    @bucket = Bucket.new(bucket_params)
    @bucket.user = current_user
    if @bucket.save
      flash[:success] = "Bucket successfully created"
      redirect_to bucket_activities_path(@bucket)
    else
      flash[:error] = "Something went wrong"
      render 'index'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @bucket.update(bucket_params)
      flash[:success] = "Activity was successfully updated"
      redirect_to @bucket
    else
      flash[:success] = "Something went wrong"
      render 'index'
    end
  end

  def destroy
    if @bucket.destroy
      redirect_to buckets_path, notice: "Bucket was succesfully deleted"
    else
      redirect_to buckets_path, notice: "Ups, we can't delete the bucket"
    end
  end
  
  private

  def find_bucket
    @bucket = Bucket.find(params[:id])
  end

  def bucket_params
    params.require(:bucket).permit(:title)
  end
end
