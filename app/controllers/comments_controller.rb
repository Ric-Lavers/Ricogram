class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    puts "params is: #{params.inspect}"
    @photo_id = params[:photo_id]
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comments.user = current_user
  end

  # GET /comments/new
  def new
    # @comment = Comment.new(:photo_id=>params[:comment_photo_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    # @comment = @photo.comments.build(comment_params)
    # @comments.user = current_user
    # @comment.save
    # redirect_to root_path

    @comment = Comment.new(comment_params)
    # @comment.photo_id = Comment.find(params[:photoID])
    @comment.user_id = current_user.id

    puts "____________"
    puts "comment_params is: #{comment_params}"
    puts "____________"
    puts "current_user.id is: #{current_user.id}"
    puts "____________"
    puts "@comment is: #{@comment.inspect}"
    puts "____________"

    respond_to do |format|
      if @comment.save
        format.html { redirect_to photos_path }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to photos_path }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      # @photo = Photo.find(params[:photo_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      # params.require(:comment).permit(:message)
      params.require(:comment).permit(:message, :user_id, :photo_id)
    end
end
