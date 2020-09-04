class Trainers::CoursesController < TrainersController
  before_action :logged_in_user, :trainer?
  before_action :get_course, except: %i(index create new)

  def index
    @courses = Course.order_by_start_date.order_by_status
                     .page(params[:page])
                     .per Settings.pagination.course.default
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "notice.success"
      redirect_to trainers_course_path @course
    else
      flash.now[:danger] = t "notice.error"
      @topics = Topic.all
      @subjects = @topics.first.subjects
      render :new
    end
  end

  def new
    @course = Course.new
    @course.course_subjects.build
    @course.user_courses.build
    @topics = Topic.all
    @subjects = @topics.first.subjects
  end

  def edit
    @subjects = @course.subjects.order_priority.page(params[:page])
                       .per Settings.pagination.subject.default
    @users = @course.users.page(params[:page])
                    .per Settings.pagination.subject.default
  end

  def show
    @subjects = @course.subjects.order_priority
    @users = @course.users
  end

  def update
    if @course.update course_params
      flash[:success] = t "notice.success"
      redirect_to trainers_course_path @course
    else
      flash.now[:danger] = t "notice.error"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "notice.success"
    else
      flash.now[:danger] = t "notice.error"
    end
    redirect_to trainers_courses_url
  end

  private

  def course_params
    params.require(:course).permit Course::COURSE_PARAMS_PERMIT
  end

  def get_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t "notice.error"
    redirect_to trainers_courses_path
  end
end
