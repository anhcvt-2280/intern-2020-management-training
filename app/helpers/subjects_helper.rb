module SubjectsHelper
  def bigger_with_now? date_time
    date_time > Time.zone.now
  end

  def task_percent complete_task, subject_id
    total_task = Subject.by_id(subject_id).first.tasks.count
    if total_task.equal? 0
      return {color: Settings.progress_course.color.level_one, percent: 0}
    end

    percent = complete_task / total_task * 100

    {percent: percent, color: color_by_percent(percent)}
  end

  def color_by_percent percent
    case percent
    when 0..25
      Settings.progress_course.color.level_one
    when 25..50
      Settings.progress_course.color.level_two
    when 50..75
      Settings.progress_course.color.level_three
    when 75..100
      Settings.progress_course.color.level_four
    else
      Settings.progress_course.color.level_five
    end
  end
end
