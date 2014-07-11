# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse do
  describe '::configure' do
    let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
    let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }

    before do
      Rnfse.configure do |config|
        config.verbose = true
        config.provedor = :iss_net
        config.municipio = :cuiaba
        config.certificate = certificate
        config.key = key
      end
    end

    after do
      Rnfse.configure do |config|
        config.verbose = nil
        config.provedor = nil
        config.municipio = nil
        config.certificate = nil
        config.key = nil
      end
    end

    it { expect(Rnfse::API.new.verbose).to eq(true) }
    it { expect(Rnfse::API.new.namespace).to eq('http://www.issnetonline.com.br/webservice/nfd') }
    it { expect(Rnfse::API.new.endpoint).to eq('http://www.issnetonline.com.br/webserviceabrasf/cuiaba/servicos.asmx') }
    it { expect(Rnfse::API.new.certificate).to eq(certificate) }
    it { expect(Rnfse::API.new.key).to eq(key) }
  end
end
