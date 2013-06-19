require 'json'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
class LogConsumer
  def initialize
    @json_messages = []
  end

  def send_people(message)
    @json_messages << %Q([ "PEOPLE", #{message} ])
  end

  def send_events(message)
    @json_messages << %Q([ "EVENTS", #{message} ])
  end

  def messages
    @json_messages.map do |j|
      JSON.load(j)
    end
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
