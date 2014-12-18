# spec/classes/init_spec.rb
require 'spec_helper'

describe "test" do

it { should contain_file('/tmp/test').with_ensure('file').with_owner('root').with_group('root').with_mode('0750')
}

end
