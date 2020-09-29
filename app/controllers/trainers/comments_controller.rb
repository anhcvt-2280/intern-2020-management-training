class Trainers::CommentsController < TrainersController
  before_action :authenticate_user!, :find_commentable
  load_and_authorize_resource only: :destroy
  # skip_authorization_check only: :create

  def create
    @comment = @commentable.comments.new comment_params
               .merge user_id: current_user.id, parent_id: params[:comment_id]
    raise ActiveRecord::RecordNotFound unless @comment.save

    respond_to :js
  end

  def destroy
    data = if Comment.find(params[:id]).destroy
             {success: t("notice.success")}
           else
             {error: t("notice.error")}
           end
    render json: data
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAM_PERMIT
  end

  def find_commentable
    @commentable = if params[:comment_id]
                     Comment.find params[:comment_id]
                   else
                     UserCourse.find_by(course_id: params[:course_id],
                                        user_id: params[:user_course_id])
                   end
  end

  def current_ability
    @current_ability ||= CommentAbility.new current_user
  end
end
