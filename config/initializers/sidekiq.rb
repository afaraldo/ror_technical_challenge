Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_HOST'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_HOST'] }
end

schedule_file = File.expand_path('../../schedule.yml', __FILE__)

if File.exists?(schedule_file)
  puts "Loading Sidekiq cron tasks from #{schedule_file}"
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
else
  puts "File no found: #{schedule_file}"
end

