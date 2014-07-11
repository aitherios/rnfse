# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API do
  describe '::new' do

    let(:certificate) { File.join($ROOT, 'spec', 'fixtures', 'certificate.pem') }
    let(:key) { File.join($ROOT, 'spec', 'fixtures', 'key.pem') }

    context 'ao passar um provedor e município,' do
      subject do
        Rnfse::API.new(provedor: :iss_net, 
                       municipio: :cuiaba, 
                       certificate: certificate,
                       key: key)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/cuiaba/servicos.asmx') }
      its(:api) { should eq('iss_net_1_0') }
      its(:xml_builder) { should be_kind_of(Rnfse::XMLBuilder) }
      its(:soap_client) { should be_kind_of(Savon::Client) }
    end

    context 'ao passar um provedor em homologação,' do
      subject do
        Rnfse::API.new(provedor: :iss_net, 
                       homologacao: true,
                       certificate: certificate,
                       key: key)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx') }
      its(:api) { should eq('iss_net_1_0') }
    end

    context 'ao passar o padrão abrasf, namespace e endpoint,' do
      subject do
        Rnfse::API.new(padrao: :abrasf_1_0, 
                       namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                       endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx',
                       certificate: certificate,
                       key: key)
      end
      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx') }
      its(:api) { should eq('abrasf_1_0') }
    end

    context 'ao não passar informações válidas,' do
      it { expect { Rnfse::API.new() }.to raise_error(ArgumentError) }
      it { expect { Rnfse::API.new(error: 'error') }.to raise_error(ArgumentError) }

      context 'como provedor inexistente,' do
        it { expect { Rnfse::API.new(provedor: :none, municipio: :cuiaba) }.to raise_error(ArgumentError) }
        it { expect { Rnfse::API.new(provedor: :none, homologacao: true) }.to raise_error(ArgumentError) }
      end
    end

  end
end
