class UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      @user.user_type = UserType.find_by_name("Visitante")
      if @user.save
        if signed_in?
          sign_in current_user
        else
          sign_in @user
        end
        format.html { redirect_to @user, notice: 'Usuario creado exitosamente.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      @user.skip_password_validation = true
      if @user.custom_update_attributes(params[:user])
        if current_user.admin?
          sign_in current_user
        else
          sign_in @user
        end
        format.html { redirect_to @user, notice: 'Perfil actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if current_user.admin?
          sign_in current_user
        else
          sign_in @user
        end
        format.html { redirect_to @user, notice: 'Password actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "password" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_type
    @user = User.find(params[:id])
  end

  def update_user_type
    @user = User.find(params[:id])

    respond_to do |format|
      @user.skip_password_validation = true
      if @user.custom_update_attributes(params[:user])
        if current_user.admin?
          sign_in current_user
        end
        format.html { redirect_to @user, notice: 'Usuario actualizado exitosamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "user_type" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
