require 'spec_helper'

describe "manageonce::file" do
  let(:node) { 'testhost.example.com' }
  let(:title) { '/tmp/test' }
  let(:params) { {
    :ensure  => 'file',
    :owner   => 'root',
    :mode    => '0644',
    :content => 'foobar',
  } }

  context "no mangeonce fact" do

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: File[/tmp/test]').with({
      :resourcetype  => 'file',
      :resourcetitle => '/tmp/test',
    })}

    it {should contain_file('/tmp/test').with({
      :ensure  => 'file',
      :owner   => 'root',
      :mode    => '0644',
      :content => 'foobar',
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
    it { should contain_manageonce('manageonce: File[/tmp/test]').with({
      :resourcetype  => 'file',
      :resourcetitle => '/tmp/test',
    })}

    it { should contain_file('/tmp/test').with({
      :ensure  => 'file',
      :owner   => 'root',
      :mode    => '0644',
      :content => 'foobar',
    })}

  end

  context "previously managed" do
    let(:facts) { {
      :manageonce => {
                        'file' => {
                          '/tmp/test' => {
                            'md5'       => "18ac0c020cf1a0e78eb4a2751b71cbb4",
                            'timestamp' => "2016-06-15 22:43:18 -0700"
                          }
                        }
                      }
    }}

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: File[/tmp/test]').with({
      :resourcetype  => 'file',
      :resourcetitle => '/tmp/test',
    })}

    it { should_not contain_file('/tmp/test') }

  end

  context "filter out parameter" do
    let(:params) { {
      :ensure     => 'file',
      :owner      => 'root',
      :mode       => '0644',
      :content    => 'foobar',
      :onlyonce   => ['content']
    } }
    let(:facts) { {
      :manageonce => {
                        'file' => {
                          '/tmp/test' => {
                            'md5'       => "18ac0c020cf1a0e78eb4a2751b71cbb4",
                            'timestamp' => "2016-06-15 22:43:18 -0700"
                          }
                        }
                      }
    }}

    it { is_expected.to contain_class('manageonce::setup') }
    it { should contain_manageonce('manageonce: File[/tmp/test]').with({
      :resourcetype  => 'file',
      :resourcetitle => '/tmp/test',
    })}

    it { should contain_file('/tmp/test').with({
      :ensure  => 'file',
      :owner   => 'root',
      :mode    => '0644',
    }).without_content }

  end

end
