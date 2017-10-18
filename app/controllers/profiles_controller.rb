class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /profiles
  # GET /profiles.json
  def index
    @users = User.all
    @profiles = Profile.all
    @current_user = current_user
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show

    if params[:id]
    # @photos = Photo.find_by_id(@profile.id)
      @profile = Profile.find_by!(user: params[:id])
      @photos = @profile.user.photos
    # puts "current: #{current_profile}"
    # puts current_profile.user.id
    # @photos = Photo.where(user_id: @profile.user)

    # verify that the photos below to the profile id shown in the url
    # @photos.each do |photo|
    #   puts Profile.find_by(user_id: photo.user_id).id
    # end
    else
      #set_profile is run here which gives me @profile
      @photos = current_user.photos
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @profile.user = current_user
  end

  # GET /profiles/1/edit
  def edit
    #@profile = Prole.find_or_initialize_by(user: current_user)

  end

  # POST /profiles
  # POST /profiles.json
  def create

    @profile = Profile.new(profile_params)
    @profile.user = current_user

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|

      if performing_follow?
         #unfollow or follow depending on what in the database
         @profile.user.toggle_followed_by(current_user)



      elsif @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      if params[:id]
        # A particular person’s profile page
        # e.g. /users/5
        @profile = Profile.find_by!(user_id: params[:id])
      else
        # The signed in user’s profile page
        # /profile
        @profile = Profile.find_by(user: current_user)
      end
    end
    def performing_follow?
     params.dig(:user, :toggle_follow).present?
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:image, :user_name, :bio)
    end
end
