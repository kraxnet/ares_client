require "ares_client"
require "minitest/autorun"

class AresClient::TestChanges < Minitest::Test
 
  def test_parsing
    changes = AresClient::Changes.from_xml(File.read('test/fixtures/2_2013-07-22_29.xml'))
    assert_equal(476, changes.added.count)
    assert_equal(4244, changes.updated.count)
    assert_equal(0, changes.deleted.count)
  end

  def test_parsing2
    changes = AresClient::Changes.from_xml(File.read('test/fixtures/4_2013-08-12_44.xml'))
    assert_equal(0, changes.added.count)
    assert_equal(2638, changes.updated.count)
    assert_equal(257, changes.deleted.count)
    assert_equal('86751166', changes.updated.sort.last)
  end

  # def test_fetching_and_parsing
  #   source = AresClient::Sources.find(4)
  #   changes = AresClient::Changes.new(source)
  #   changes.fetch(44)
  #   assert_equal(0, changes.added.count)
  #   assert_equal(2638, changes.updated.count)
  #   assert_equal(257, changes.deleted.count)
  # end

end


