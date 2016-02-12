require_relative 'spec_helper'
require_relative 'centos67_options'

describe 'user_shadow_test::default on Centos 6.7' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS67_SERVICE_OPTS) do |node|
      node_resources(node)
    end.converge('user_shadow_test::default')
  end

  it_behaves_like 'testuser'
end
