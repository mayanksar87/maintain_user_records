# config/initializers/redis.rb

if Rails.env.development? || Rails.env.test?
  $redis = Redis.new(url: 'redis://localhost:6379/1')
else
  # For production, you might want to use a connection pool, and the Redis Cloud URL or your own Redis server.
  $redis = Redis.new(url: ENV['REDIS_URL'])
end
