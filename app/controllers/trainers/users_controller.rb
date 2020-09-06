class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_user, :get_data, only: %i(edit update)

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "notice.success"
      redirect_to trainers_user_path @user
    else
      flash.now[:danger] = t "notice.error"
      render :edit
    end
  end

  private

  def get_user
    @user = User.find_by id: params[:id] if params[:id].present?
    return if @user

    flash[:danger] = t "notice.error"
    redirect_to trainers_users_path
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS_PERMIT
  end

  def get_data
    @program_language = ProgramLanguage.all
    @position = Position.all
    @department = Department.all
    @school = School.all
    @office = Office.all
  end
end
