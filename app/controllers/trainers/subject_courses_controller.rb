class Trainers::SubjectCoursesController < TrainersController
  def show
    @course = Course.find_by id: params[:course_id]
    @subject = @course.subjects.find_by id: params[:id]
    @users = @course.users
  end
end
