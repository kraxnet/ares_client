require "ares_client"
require "minitest/autorun"

class AresClient::TestSources < Minitest::Test

  def test_find
    source = AresClient::Sources.find(2)
    assert_equal('OR', source.name)
  end

  def test_find_by_name
    source = AresClient::Sources.find_by_name('OR')
    assert_equal(2, source.id)
  end

  def test_collection
    all = AresClient::Sources.all
    assert_equal(2, all.size)
    assert_equal(AresClient::Sources, all.first.class)
  end

end
