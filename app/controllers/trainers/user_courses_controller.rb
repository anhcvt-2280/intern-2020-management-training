class Trainers::UserCoursesController < TrainersController
  def show
    @course = Course.find_by id: params[:course_id]
    @subjects = @course.subjects
    @user = User.find_by(id: params[:id])
  end
end
