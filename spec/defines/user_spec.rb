require 'spec_helper'

describe "manageonce::user" do
  let(:node) { 'testhost.example.com' }
  let(:title) { 'bob' }
  let(:params) { {
    :ensure   => 'present',
    :gid      => '1000',
    :home     => '/home/bob',
    :password => '$1$Tge1IxzI$kyx2gPUvWmXwrCQrac8/m0', # puppetlab
  } }

  context "no mangeonce fact" do

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: User[bob]').with({
      :resourcetype  => 'user',
      :resourcetitle => 'bob',
    })}

    it {should contain_user('bob').with({
      :ensure   => 'present',
      :gid      => '1000',
      :home     => '/home/bob',
      :password => '$1$Tge1IxzI$kyx2gPUvWmXwrCQrac8/m0' # puppetlab
    })}

  end

  context "not previously managed" do
    let(:facts) { {
      :manageonce => {
                        'file' => {
                          '/tmp/another/file' => {
                            'md5'       => "18ac0c020cf1a0e78eb4a2751b71cbb4",
                            'timestamp' => "2016-06-15 22:43:18 -0700"
                          }
                        }
                      }
    }}

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: User[bob]').with({
      :resourcetype  => 'user',
      :resourcetitle => 'bob',
    })}

    it {should contain_user('bob').with({
      :ensure   => 'present',
      :gid      => '1000',
      :home     => '/home/bob',
      :password => '$1$Tge1IxzI$kyx2gPUvWmXwrCQrac8/m0' # puppetlab
    })}

  end

  context "previously managed" do
    let(:facts) { {
      :manageonce => {
                        'user' => {
                          'bob' => {
                            'timestamp' => "2016-06-15 22:43:18 -0700"
                          }
                        }
                      }
    }}

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: User[bob]').with({
      :resourcetype  => 'user',
      :resourcetitle => 'bob',
    })}

    it { should_not contain_user('bob') }

  end

  context "filter out parameter" do
    let(:params) { {
      :ensure   => 'present',
      :gid      => '1000',
      :home     => '/home/bob',
      :password => '$1$Tge1IxzI$kyx2gPUvWmXwrCQrac8/m0', # puppetlab
      :onlyonce   => ['password']
    } }
    let(:facts) { {
      :manageonce => {
                        'user' => {
                          'bob' => {
                            'timestamp' => "2016-06-15 22:43:18 -0700"
                          }
                        }
                      }
    }}

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: User[bob]').with({
      :resourcetype  => 'user',
      :resourcetitle => 'bob',
    })}

    it {should contain_user('bob').with({
      :ensure   => 'present',
      :gid      => '1000',
      :home     => '/home/bob',
    }).without_password }


  end

end
