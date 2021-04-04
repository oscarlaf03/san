class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only:[:show, :update]

  def index
    authorize User
    @users = policy_scope(User)
  end

  def show
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      render :show, status: :created
    else
      render_error(@user)
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      render :show
    else
      render_error(@user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(*User.params)
  end

end
