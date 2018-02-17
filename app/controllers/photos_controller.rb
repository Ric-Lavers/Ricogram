class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: :edit

  def require_permission
    if current_user != Photo.find(params[:id]).user
      redirect_to root_path
    end
  end
  # GET /photos
  # GET /photos.json
  def index
    if current_user.profile == nil
      redirect_to(controller: :profiles, action: :new)
    end

    # @myTest = Comment.where(user_id:(@current_user.id))
    @photos = Photo.all
    @users = User.all
    @comments = Comment.all
    @comment = Comment.new
    @profiles = Profile.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show

    @photo.user = current_user
    @comments = Comment.where(user_id: params[:id])
    puts "#{params[:id]}".green
    @users = User.all
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    @photo.user = current_user
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user #devise method for current user
    # Created by SCAFFOLD
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def downvote
    @photo = Photo.find(params[:id])
    @photo.downvote_by current_user

    @new_vote = @photo.get_upvotes.size

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end

  end
  def upvote
    @photo = Photo.find(params[:id])
    @photo.upvote_by current_user

    @new_vote = @photo.get_upvotes.size

    respond_to do |format|
     format.html { redirect_to :back }
     format.js { render layout: false }
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :user_id, :caption)
    end
end
