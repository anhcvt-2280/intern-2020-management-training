class Trainers::UserCoursesController < TrainersController
  before_action :authenticate_user!
  before_action :get_course_user, only: :show
  authorize_resource User

  def show
    @subjects = Subject.by_course(params[:course_id]).order_priority
    @comments = @user_course.comments.order_by_created_at
                            .page(params[:page])
                            .per Settings.pagination.course.default
  end

  private

  def get_course_user
    @course = Course.find_by id: params[:course_id]
    @user = User.find_by id: params[:id]
    @user_course = UserCourse.find_by(course_id: params[:course_id],
                                      user_id: params[:id])
    return if @course && @user && @user_course

    flash[:danger] = t "notice.error"
    redirect_to trainers_courses_path
  end
end
