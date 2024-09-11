require "test_helper"

class EconomicProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get economic_projects_index_url
    assert_response :success
  end
end
