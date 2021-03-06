require 'spec_helper'

describe FoxySync::Sso do
  include FoxySync::Sso

  include_examples 'api setup'
  include_examples 'user'


  let :params do
    { 'fcsid' => 'abc123', 'timestamp' => Time.now.to_i.to_s }
  end


  it 'should give the correct URL when no user is given' do
    url = sso_url params
    expect(url).to match fc_sso_url
  end

  it 'should give the correct URL when a user is given' do
    cid = 3
    FoxySync::Api::Customer.any_instance.stub(:customer_id).and_return cid
    url = sso_url params, user
    expect(url).to match fc_sso_url cid
  end


  def fc_sso_url(cid = 0)
    /#{FoxySync.store_url}\/checkout\?fc_auth_token=[0-9a-z]+&fcsid=#{params['fcsid']}&fc_customer_id=#{cid}&timestamp=\d+/
  end

end