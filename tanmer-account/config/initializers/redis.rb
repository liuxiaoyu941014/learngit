redis =  Redis.new(
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT']
)

Redis.current = Redis::Namespace.new(ENV['REDIS_NAMESPACE'], :redis => redis)
