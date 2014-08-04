# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API::Abrasf10 do
  let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
  let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }
  let(:client) do
    Rnfse::API.new(padrao: :abrasf_1_0, 
                   namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                   endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx',
                   certificate: certificate,
                   key: key)
  end

  describe '#operations' do
    it { expect(client.operations).to eq([
      :recepcionar_lote_rps, :consulta_situacao_lote_rps, 
      :consultar_nfse_por_rps, :consultar_nfse, :consultar_lote_rps,
      :cancelar_nfse
    ]) }
  end

  describe '#recepcionar_lote_rps' do
    it { expect(client).to respond_to(:recepcionar_lote_rps) }

    context 'ao não passar opções certificate e key para assinatura do xml,' do
      let(:client) do
        Rnfse::API.new(padrao: :abrasf_1_0, 
                       namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                       endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx')
      end

      it { expect { client.recepcionar_lote_rps() }.to raise_error(ArgumentError) }
    end
  end

  describe '#consulta_situacao_lote_rps' do
    it { expect(client).to respond_to(:consultar_situacao_lote_rps) }
  end

  describe '#consultar_nfse_por_rps' do
    it { expect(client).to respond_to(:consultar_nfse_por_rps)  }
    it { expect { client.consultar_nfse_por_rps() }.to raise_error(Rnfse::Error::NotImplemented) }
  end

  describe '#consultar_nfse' do
    it { expect(client).to respond_to(:consultar_nfse) }
  end

  describe '#consultar_lote_rps' do
    it { expect(client).to respond_to(:consultar_lote_rps) }
  end

  describe '#cancelar_nfse' do
    it { expect(client).to respond_to(:cancelar_nfse)  }
    it { expect { client.cancelar_nfse() }.to raise_error(Rnfse::Error::NotImplemented) }
  end
end
