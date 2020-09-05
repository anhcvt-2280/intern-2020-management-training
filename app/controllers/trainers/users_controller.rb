class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_user, only: :show
  before_action :get_data, only: %i(new create)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "notice.success"
      redirect_to trainers_user_path @user
    else
      flash.now[:danger] = t "notice.error"
      render :new
    end
  end

  def show; end

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
