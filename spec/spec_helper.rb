RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.before(:all) { $stdout = File.new('/dev/null', 'w') }
end

require_relative "../app/moveable"
require_relative "../app/colorize"
require_relative "../app/gamestate"
require_relative "../app/display"
require_relative "../app/human"
require_relative "../app/ai"
require_relative "../app/tictactoe"

require_relative "helpers/test_helpers"
