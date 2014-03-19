class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_user, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(name: params[:user][:name], email: params[:user][:email].downcase)
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.avatar = params[:user][:avatar].tempfile
    #@user.password = BCrypt::Password.create(params[:user][:password])
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
    if params[:user][:password_input].to_s[' ']
      redirect_to signup_path, notice: 'Password contains blank(s)' 
      return
    elsif params[:user][:password_input] != params[:user][:password_confirm]
      redirect_to signup_path, notice: 'Retyped password does not match' 
      return
    end

    respond_to do |format|
      if @user.update(name: params[:user][:name], email: params[:user][:email].downcase, password: BCrypt::Password.create(params[:user][:password_input]))
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
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
