class Trainers::UsersController < TrainersController
  before_action :logged_in_user, :trainer?

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
end
