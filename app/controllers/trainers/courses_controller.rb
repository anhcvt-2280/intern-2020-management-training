class Trainers::CoursesController < TrainersController
  before_action :authenticate_user!
  before_action :get_course, except: %i(index create new)
  before_action :load_data, only: %i(show edit update)
  load_and_authorize_resource

  def index
    @q = Course.ransack params[:q]
    @courses = @q.result
                 .order_by_start_date.order_by_status
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

  def edit; end

  def show; end

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
    redirect_to trainers_courses_path
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

  def load_data
    @test = Subject.task_of_subject 1
    @test2 = Subject.includes :tasks, :topics
    @preload =
    binding.pry
    @subjects = @course.subjects.order_priority
    @users = @course.users
  end
end
