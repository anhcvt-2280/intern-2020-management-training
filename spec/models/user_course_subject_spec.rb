require "rails_helper"

RSpec.describe UserCourseSubject, type: :model do
  let!(:course_1) {FactoryBot.create :course, status: "opening"}
  let!(:cs_1) {FactoryBot.create :course_subject, course: course_1}
  let!(:ucs_1) {FactoryBot.create :user_course_subject, course_subject: cs_1, status: "inprogress", deadline: "2020-09-22"}

  describe "Scopes" do
    describe ".status" do
      context "when nil params" do
        it "return all user_course_subject" do
          expect(UserCourseSubject.status(nil).count).to eq UserCourseSubject.count
        end
      end

      context "when valid params" do
        it "return user_course_subject that has status is params value" do
          expect(UserCourseSubject.status("inprogress").count).to eq 1
        end
      end
    end

    describe ".by_user" do
      context "when nil params" do
        it "return all user_course_subject" do
          expect(UserCourseSubject.by_user(nil).count).to eq UserCourseSubject.count
        end
      end

      context "when valid params" do
        it "return user_course_subject that belongs to user has id = param" do
          expect(UserCourseSubject.by_user(ucs_1.user_id).pluck(:user_id)).to eq [ucs_1.user_id]
        end
      end
    end

    describe ".opening_course" do
      it "return user_course_subject belongs to opening course" do
        expect(UserCourseSubject.opening_course.pluck(:id)).to eq [ucs_1.id]
      end
    end

    describe ".deadline_between" do
      context "when nil param" do
        it "return ActiveRecord::Relation []" do
          expect(UserCourseSubject.deadline_between(nil, nil).count).to eq 0
        end
      end

      context "when valid param" do
        it "return subject with deadline between date_from and date_to" do
          expect(UserCourseSubject.deadline_between("2020-09-12", "2020-09-25").pluck(:id)).to eq [ucs_1.id]
        end
      end
    end
  end

  describe "Associations" do
    [:user, :course_subjetc, :user_course].each do |model|
      it {belong_to(model)}
    end

    it "has many user tasks" do
      is_expected.to have_many(:user_tasks).dependent :destroy
    end
  end

end
