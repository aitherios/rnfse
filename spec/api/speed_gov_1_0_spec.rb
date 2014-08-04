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

  describe '#operations' do
    it { expect(client.operations).to eq([
      :recepcionar_lote_rps, :consultar_situacao_lote_rps,
      :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
      :cancelar_nfse
    ]) }
  end

  describe '#recepcionar_lote_rps' do
    it { expect(client).to respond_to(:recepcionar_lote_rps)  }
    it { expect { client.recepcionar_lote_rps() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#consultar_situacao_lote_rps' do
    it { expect(client).to respond_to(:consultar_situacao_lote_rps)  }
    it { expect { client.consultar_situacao_lote_rps() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#consultar_nfse_por_rps' do
    it { expect(client).to respond_to(:cancelar_nfse)  }
    it { expect { client.cancelar_nfse() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#consultar_nfse' do

    context 'quando parametros errados são passados,' do
      it { expect{ client.consultar_nfse(bogus: :data) }.to raise_error(ArgumentError) }
    end

    it { expect(client).to respond_to(:consultar_nfse) }

    subject do
      VCR.use_cassette('speed_gov_1_0_consultar_nfse') do
        client.consultar_nfse({
          prestador: {
            cnpj: "12.552.510/0001-50",
            inscricao_municipal: "68"
          }
        })
      end
    end

    it { should_not be_nil }
    it { should be_kind_of(Hash) }
  end

  describe '#consultar_lote_rps' do
    it { expect(client).to respond_to(:consultar_lote_rps)  }
    it { expect { client.consultar_lote_rps() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#cancelar_nfse' do
    it { expect(client).to respond_to(:cancelar_nfse)  }
    it { expect { client.cancelar_nfse() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

end
