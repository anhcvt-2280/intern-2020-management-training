class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_user, only: %i(show destroy)
  before_action :get_data, only: %i(new create)

  def index
    @users = if params[:query].present?
               User.by_name params[:query]
             else
               User
             end
    @users = @users.page(params[:page])
                 .per Settings.pagination.course.default
    respond_to :js, :html
  end

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

  def destroy
    if @user.destroy
      flash[:success] = t "notice.success"
    else
      flash.now[:danger] = t "notice.error"
    end
    redirect_to trainers_users_path
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
