class Trainers::ImportUsersController < TrainersController
  before_action :authenticate_user!
  before_action :import_user_param
  authorize_resource User

  def create
    full_path_file = "public" + upload_file.to_s
    AddUserByExcelJob.set(wait: Settings.sidekiq.delay_time.minute)
                     .perform_later full_path_file
    flash[:success] = t "notice.success"
    redirect_to trainers_users_path
  rescue CarrierWave::IntegrityError
    flash[:danger] = t "notice.error"
    redirect_to trainers_users_path
  end

  private

  def import_user_param
    return if params[:import_user][:file]

    flash[:error] = t "notice.error"
    redirect_to trainers_users_path
  end

  def upload_file
    uploader = ImportUserUploader.new
    uploader.store! params[:import_user][:file]
    uploader
  end
end
