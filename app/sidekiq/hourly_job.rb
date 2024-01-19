class HourlyJob
  include Sidekiq::Worker

  def perform
    response = HTTParty.get('https://randomuser.me/api/?results=20')
    users = response['results']

    users.each do |user_data|
      user = User.find_or_initialize_by(uuid: user_data['login']['uuid'])
      user.attributes = {
        uuid: user_data['login']['uuid'],
        name: user_data['name'],
        location: user_data['location'],
        gender: user_data['gender'],
        age: user_data['dob']['age'],
        created_at: Time.now
      }
      user.save

      update_gender_count(user.gender)
    end
  end

  private

  def update_gender_count(gender)
    Redis.current.incr(gender.downcase + '_count')
  end
end
