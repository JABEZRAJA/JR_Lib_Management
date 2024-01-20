class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    return if @user.present?

    render json: { error: 'User not found' }, status: 404
  end

  def index
    # @all_users = User.all
    @all_users = User.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Welcome to JR Library Management :)'
      log_in @user
      redirect_to users_path
    else
      render :new
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params.merge(password: params[:user][:password]))
      flash[:notice] = 'Successfully Updated :)'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_path
  end

  def home
    @books = Book.all
    @all_users = User.all.paginate(page: params[:page], per_page: 10)
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password, :first_name, :last_name, :email, :phone_number, :user_role)
  end
end
