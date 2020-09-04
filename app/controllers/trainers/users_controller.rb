class Trainers::UsersController < TrainersController
  before_action :get_user, only: :show
  def show; end

  private

  def get_user
    @user = User.find_by id: params[:id] if params[:id].present?
    return if @user

    flash[:danger] = t "notice.error"
    redirect_to trainers_users_path
  end
end
