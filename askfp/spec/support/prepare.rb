RSpec.configure do |config|
  config.before :suite do
    fixture_path = Rails.root.join("db", "fixtures")
    SeedFu.seed(fixture_path)
  end

  config.after :suite do
  end
end
