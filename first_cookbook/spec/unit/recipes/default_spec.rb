#
# Cookbook:: first_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'first_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 8' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '8'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When first_cookbook run, on CentOS 8' do
    platform 'centos', '8'
    let(:template) { chef_run.template('/var/www/html/index.html') }

    it 'installs httpd' do 
      expect {chef_run}.to install_package('httpd')
    end
    
    it 'starts httpd' do
      expect {chef_run}.to start_service('httpd')
    end
    
    it 'creates file with interfaces' do
      expect {chef_run}.to create_file('/tmp/interfaces.txt')
    end
    
    it 'renders template' do
      expect {chef_run}.to render_file('/var/www/html/index.html').with_content(/(Hello).*(ipaddress).*(hostname)/gs)
    end
    
    it 'restarts httpd' do 
      expect(template).to notify('service[httpd]').to(:restart)
    end

  end
end
