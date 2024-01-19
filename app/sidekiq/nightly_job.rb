class NightlyJob
  include Sidekiq::Worker

  def perform
    male_count = Redis.current.get('male_count').to_i
    female_count = Redis.current.get('female_count').to_i

    DailyRecord.create!(
      date: Date.today,
      male_count: male_count,
      female_count: female_count
    )
  end
end
