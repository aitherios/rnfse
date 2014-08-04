# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API::SpeedGov10 do
  let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
  let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }
  let(:client) do
    Rnfse::API.new(padrao: :speed_gov_1_0, 
                   namespace: 'http://ws.speedgov.com.br/',
                   endpoint: 'http://speedgov.com.br/wsmod/Nfes',
                   certificate: certificate,
                   key: key)
  end

  describe '#consultar_nfse' do

    context 'quando parametros errados são passados,' do
      xit { expect{ client.consultar_nfse(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:consultar_nfse) }

    subject do
    end
    
  end
end
