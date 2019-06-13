namespace :default_data do
  desc 'set default data'
  task set: :environment do
    exec "rake db:seed_fu FILTER=01_time_frame"
  end
end
