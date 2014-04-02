class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_password, :update_password, :edit_avatar, :update_avatar]
  skip_before_action :require_user, only: [:new, :create]
  before_action only: [:edit, :update, :destroy, :edit_password, :update_password, :edit_avatar, :update_avatar] do
    allow_edit(User.find(params[:id]))
  end


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @trips = @user.trips
  end

  def showname
    @user = User.find_by(:nickname => params[:id])
    unless @user.nil?
      show
      render :show
    else
      # 404 page, nickname not found
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET/users/1/password
  def edit_password
  end

  # GET/users/1/edit_avatar
  def edit_avatar
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email].downcase)
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.nickname = params[:user][:nickname]
    @user.avatar = params[:user][:avatar]
    session[:user_id] = @user.id

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        msg = @user.errors.messages.keys()[0].to_s + ' '
        msg += @user.errors.messages[@user.errors.messages.keys()[0]][0]
        format.html { redirect_to signup_path, notice: msg }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        # 'Account already exists.'
      end
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.name = params[:user][:name]
    @user.email = params[:user][:email].downcase
    @user.nickname = params[:user][:nickname]

    respond_to do |format|
      if @user.update
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update_password
    if BCrypt::Password.new(@user.password_hash) == params[:user][:password_old]
      @user.password_hash = nil
      @user.password = params[:user][:password]  
      @user.password_confirmation = params[:user][:password_confirmation]
    else
      redirect_to edit_password_path(@user), notice: 'Incorrect old password'
      return
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Password is updated successfully.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        msg = @user.errors.messages.keys()[0].to_s + ' '
        msg += @user.errors.messages[@user.errors.messages.keys()[0]][0]
        format.html { redirect_to edit_password_path(@user), notice: msg }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_avatar
    @user.avatar = params[:user][:avatar]
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'New avatar uploaded.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        msg = @user.errors.messages.keys()[0].to_s + ' '
        msg += @user.errors.messages[@user.errors.messages.keys()[0]][0]
        format.html { redirect_to edit_avatar_path(@user), notice: msg }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully created.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :avatar)
    end

end
