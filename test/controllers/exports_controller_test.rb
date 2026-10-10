require "test_helper"

class ExportsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "an export request records its amount and deadline" do
    assert_difference "Note.count", 1 do
      perform_enqueued_jobs do
        post exports_path, params: { export: {
          title: "Friday review", amount: "1.25",
          deadline: "2020-01-01T00:00:00Z", time_zone: "UTC"
        } }
      end
    end
    note = Note.find_by!("title = ?", "Friday review")

    assert_response :created
    assert_equal({ "amount" => "1.25", "deadline" => "2020-01-01T00:00:00Z" }, note.metadata)
  end
end
