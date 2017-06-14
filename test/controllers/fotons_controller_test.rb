require 'test_helper'

class FotonsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @fotons = Foton.all
  end

  test "show all fotons" do
    get root_url
    assert_select 'div.foton', count: @fotons.count
  end
end
