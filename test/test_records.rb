# -*- encoding : utf-8 -*-

require "ares_client"
require "minitest/autorun"

class AresClient::TestRecords < Minitest::Test

  def test_parsing
    record = AresClient::Records.from_xml(File.read('test/fixtures/67787231.xml'))
    assert_equal('Ing. Jiří Kubíček', record.name)
    assert_equal('67787231', record.ic)
    assert_equal('CZ8002180461', record.dic)
    assert_equal('22301224', record.address_code)
    assert_equal('22139753', record.building_code)
    assert_equal('Kamenická', record.street)
    assert_equal('599', record.street_no)
    assert_equal('Praha', record.city)
    assert_equal('Česká republika', record.country)
    assert_equal('17000', record.zip)
    assert_nil(record.court_name)
    assert_nil(record.court_reg_no)
  end

  def test_fetching_and_parsing
    record = AresClient::Records.find_by_ic('67787231')
    assert_equal('Ing. Jiří Kubíček', record.name)
    assert_equal('67787231', record.ic)
    assert_equal('CZ8002180461', record.dic)
    assert_equal('22301224', record.address_code)
    assert_equal('22139753', record.building_code)
    assert_equal('Kamenická', record.street)
    assert_equal('599', record.street_no)
    assert_equal('Praha', record.city)
    assert_equal('Česká republika', record.country)
    assert_equal('17000', record.zip)
    assert_nil(record.court_name)
    assert_nil(record.court_reg_no)
  end

  def test_record_found
    record = AresClient::Records.from_xml(File.read('test/fixtures/67787231.xml'))
    assert_equal(true, record.found?)
  end

  def test_record_not_found
    record = AresClient::Records.from_xml(File.read('test/fixtures/68972085.xml'))
    assert_equal(false, record.found?)
  end

end