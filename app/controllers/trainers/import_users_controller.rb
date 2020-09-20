class Trainers::ImportUsersController < TrainersController
  def create
    AddUserByExcelJob.set(wait: 1.minutes).perform_later "Ta"
  end
end
