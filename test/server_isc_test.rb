require_relative '_test_header'
require 'dhcp/server/isc'

class DHCPServerIscTest < Test::Unit::TestCase

  def setup
    exit unless TestConfig::ISC_TESTS

    #UGLY workaround for now
    @server = @server || DHCP::Server::ISC.new(:name => TestConfig::SERVER, :config => TestConfig::CONF_FILE, :leases => TestConfig::LEASE_FILE)
  end

  def find_subnet
    @subnet = @server.find_subnet TestConfig::SUBNET
  end

  def test_it_should_get_subnets_data
    assert @server.subnets.size > 0
  end

    def test_should_load_subnet_records
    find_subnet
    @server.loadSubnetData @subnet
    assert @subnet.records.size > 0
  end

#  def test_subnet_should_have_options
#    find_subnet
#    @server.loadSubnetOptions @subnet
#    assert @subnet.options.size > 0
#  end

#  def test_subnet_should_have_options_and_values
#    find_subnet
#    @server.loadSubnetOptions @subnet
#    error = false
#    @subnet.options.each do |o,v|
#      error = true if o.nil? or o.empty? or v.nil? or o.empty?
#    end
#    assert error == false
#  end

#  def test_records_should_have_options
#    find_subnet
#    @server.loadSubnetData @subnet
#    record = @subnet.records.first
#    @server.loadRecordOptions record
#    assert record.options.size > 0
#  end

#  def test_records_should_have_options_and_values
#    find_subnet
#    @server.loadSubnetData @subnet
#    record = @subnet.records.first
#    @server.loadRecordOptions record
#    error = false
#    record.options.each { |o,v| error = true if o.nil? or o.empty? or v.nil? or v.empty? }
#    assert error == false
#  end

  def test_should_find_unused_ip
    if TestConfig::NET_TESTS
      find_subnet
      ip = @subnet.unused_ip
      assert ip =! nil
    else
      puts 'Skipping test_should_find_unused_ip, because network-aware testing is off'
    end
  end

end
