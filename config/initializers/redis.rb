if Rails.env.development? || Rails.env.test?
  $redis = Redis.new(url: 'redis://localhost:6379/1')
else
  $redis = Redis.new(url: ENV['REDIS_URL'])
end
