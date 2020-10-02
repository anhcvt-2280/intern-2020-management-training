require "rails_helper"

RSpec.describe Course, type: :model do
  let(:course) {FactoryBot.build :course}
  let(:invalid_course) {FactoryBot.build :course, name: nil}
  let!(:course_two) do
    FactoryBot.create :course, status: :finished, start_date: "14-09-2020",
                      created_at: "14-09-2020",
                      updated_at: "14-09-2020"
  end
  let!(:course_three) do
    FactoryBot.create :course,  status: :postponed, start_date: "15-09-2020",
                      created_at: "15-09-2020"
  end

  describe "Validations" do
    it "valid all field" do
      expect(course.valid?).to eq true
    end

    it "invalid any field" do
      expect(invalid_course.valid?).to eq false
    end
  end

  describe "Associations" do
    it "has many subjects" do
      is_expected.to have_many :subjects
    end

    it "has many users" do
      is_expected.to have_many :users
    end

    it "has many reports" do
      is_expected.to have_many(:reports).dependent :destroy
    end
  end

  describe "Nested attributes" do
    it "course subject" do
      is_expected.to accept_nested_attributes_for(:course_subjects).allow_destroy true
    end

    it "user subject" do
      is_expected.to accept_nested_attributes_for(:user_courses).allow_destroy true
    end
  end

  describe "Enums" do
    it "role status" do
      is_expected.to define_enum_for(:status)
                 .with_values deleted: 0, finished: 1, postponed: 2, opening: 3
    end
  end

  describe "Scopes" do
    it "order by start date" do
      expect(Course.order_by_start_date.pluck(:start_date))
          .to eq ["15-09-2020".to_date, "14-09-2020".to_date]
    end

    it "order by status" do
      expect(Course.order_by_status.pluck(:id)).to eq [course_three.id, course_two.id]
    end
  end

  describe "#progress_by_user" do
    context "with invalid user course" do
      it "return nil" do
        expect(course_two.progress_by_user(nil)).to eq nil
      end
    end

    context "with valid user course" do
      let!(:valid_user) {FactoryBot.create :user}
      let!(:valid_user_course) do
        FactoryBot.create :user_course, course: course_two, user: valid_user, progress: 10
      end

      it "return progress user" do
        expect(course_two.progress_by_user(valid_user.id)).to eq 10
      end
    end
  end

  describe "#started_at" do
    it "started at formatter" do
      expect(course_two.stated_at).to eq "14-09-2020"
    end
  end

  describe "#updated_at_custom" do
    it "updated at formatter" do
      expect(course_two.updated_at_custom).to eq "14-09-2020"
    end
  end

  describe "#ended_at" do
    context "with valid param" do
      it "ended at formatter" do
        expect(course_two.ended_at(2)).to eq "16-09-2020"
      end
    end

    context "with invalid param" do
      it "ended at formatter" do
        expect(course_two.ended_at(nil)).to eq "14-09-2020"
      end
    end
  end
end
