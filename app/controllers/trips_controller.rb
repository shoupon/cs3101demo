class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @user = User.find(params[:user_id])
    @trips = @user.trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @user = User.find(params[:user_id])
    @photos = @trip.photos.all
  end

  # GET /trips/new
  def new
    @user = User.find(params[:user_id])
    @trip = Trip.new
    @photos = @trip.photos.build
  end

  # GET /trips/1/edit
  def edit
    @user = User.find(params[:user_id])
  end

  # POST /trips
  # POST /trips.json
  def create
    @user = User.find(params[:user_id])
    @trip = Trip.new
    @trip.start = params[:trip][:start]
    @trip.end = params[:trip][:end]
    @trip.user = @user
    upload_photos(params[:trip][:photos])
    
    respond_to do |format|
      if @trip.save!
        format.html { redirect_to [@user,@trip], notice: 'Trip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        msg = @trip.errors.messages.keys()[0].to_s + ' '
        msg += @trip.errors.messages[@trip.errors.messages.keys()[0]][0]
        format.html { render action: 'new', notice: msg }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to [@user,@trip], notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    @user = User.find(params[:user_id])
    @trip = Trip.find(params[:id])
  end
  
  def upload_action
    @user = User.find(params[:user_id])
    @trip = Trip.find(params[:id])
    upload_photos(params[:trip][:photos])
    
    respond_to do |format|
      if @trip.save!
        format.html { redirect_to [@user,@trip], notice: 'Trip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        msg = @trip.errors.messages.keys()[0].to_s + ' '
        msg += @trip.errors.messages[@trip.errors.messages.keys()[0]][0]
        format.html { render action: 'new', notice: msg }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @user = User.find(params[:user_id])
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to user_trips_url(@user) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:start, :end, :photo => [:image])
    end

    def upload_photos(files)
      count = 0
      files.each do |f|
        if count < 10
          p = Photo.new
          p.image = f[:file]
          p.save!
          @trip.photos << p 
          count += 1
        end
      end
    end
end
