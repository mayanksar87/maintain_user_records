class DailyRecord < ApplicationRecord
  after_save :calculate_average_age, if: :gender_counts_changed?

  private

  def gender_counts_changed?
    saved_change_to_male_count? || saved_change_to_female_count?
  end

  def calculate_average_age
    male_users = User.where(gender: 'male')
    female_users = User.where(gender: 'female')

    update!(
      male_avg_age: calculate_avg_age(male_users),
      female_avg_age: calculate_avg_age(female_users)
    )
  end

  def calculate_avg_age(users)
    return 0 if users.empty?

    total_age = users.sum(:age)
    total_users = users.count
    total_age.to_f / total_users
  end
end
