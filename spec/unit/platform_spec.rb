require 'spec_helper'


describe "Test if patch is applied on Platform" do

  describe 'Windows is succesfully patched for transport sspinegotiate', :windows_only do
    before do
      require 'winrm-s'
      @winrm = WinRM::WinRMWebService.new("http://mywinrmhost:5985/wsman", :sspinegotiate, :user => "test_winrm_user", :pass => "test_winrm_pass")
    end

    it 'HTTP::HttpSSPINegotiate class should exist' do
      expect{WinRM::HTTP::HttpSSPINegotiate}.not_to raise_exception
    end

    it 'should patch httpclient to contain encrypt/decrypt methods' do
      expect(HTTPClient::SSPINegotiateAuth.new).to respond_to(:encrypt_payload)
      expect(HTTPClient::SSPINegotiateAuth.new).to respond_to(:decrypt_payload)
    end

  end

  describe 'Winrm cannot be patched for unix', :unix_only do
    it 'require winrm-s should raise exception' do
      expect{require 'winrm-s'}.to raise_exception RuntimeError
    end
  end
end
