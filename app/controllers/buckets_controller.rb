class BucketsController < ApplicationController
  before_action :find_bucket, only: [:show, :destroy]

  def index
    @buckets = Bucket.all
  end
  
  def new
    @bucket = Bucket.new
  end
  
  def create
    @bucket = Bucket.new(find_bucket)
    if @bucket.save
      flash[:success] = "Bucket successfully created"
      redirect_to @bucket
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def show
  end

  def destroy
    if @bucket.destroy
      redirect_to buckets_path, notice: "Bucket was succesfully del"
  end
  
  private

  def find_bucket
    @bucket = Bucket.find(params[:id])
  end

  def bucket_params
    paramas.require(:bucket).permit(:title)
  end
end
