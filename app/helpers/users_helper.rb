module UsersHelper
  def trainer?
    current_user.role_trainer? if logged_in?
  end

  def trainee?
    current_user.role_trainee? if logged_in?
  end

  def gender user
    return t("trainers.users.show.label_female") if user.gender_male?

    t "trainers.users.show.label_male"
  end

  def role user
    return t("trainers.users.show.label_role_trainer") if user.role_trainer?

    t "trainers.users.show.label_role_trainee"
  end
end
