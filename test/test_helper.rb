ENV["RAILS_ENV"] = "test"
ENV["NOTEBOOK_DB"] = "margin_notes_test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  fixtures :all
end
