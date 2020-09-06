class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_user, only: :destroy

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
end
