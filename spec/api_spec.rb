# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::API do
  describe '::new' do

    context 'ao passar um padrão, namespace e endpoint,' do
      subject do
        Rnfse::API.new(padrao: :abrasf_1_0, 
                       namespace: 'http://www.issnetonline.com.br/webservice/nfd',
                       endpoint: 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx')
      end
      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx') }
      its(:api) { should eq('abrasf_1_0') }
      its(:xml_builder) { should be_kind_of(Rnfse::XMLBuilder) }
      its(:soap_client) { should be_kind_of(Savon::Client) }
    end

    context 'ao não passar informações válidas,' do
      it { expect { Rnfse::API.new() }.to raise_error(ArgumentError) }
      it { expect { Rnfse::API.new(error: 'error') }.to raise_error(ArgumentError) }

      context 'como provedor inexistente,' do
        it { expect { Rnfse::API.new(provedor: :none, municipio: :cuiaba) }.to raise_error(ArgumentError) }
        it { expect { Rnfse::API.new(provedor: :none, homologacao: true) }.to raise_error(ArgumentError) }
      end
    end

    context 'ISS.net ao passar um provedor e município,' do
      subject do
        Rnfse::API.new(provedor: :iss_net, 
                       municipio: :cuiaba)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/cuiaba/servicos.asmx') }
      its(:api) { should eq('iss_net_1_0') }
    end

    context 'ISS.net ao passar um provedor em homologação,' do
      subject do
        Rnfse::API.new(provedor: :iss_net, 
                       homologacao: true)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://www.issnetonline.com.br/webservice/nfd') }
      its(:endpoint) { should eq('http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx') }
      its(:api) { should eq('iss_net_1_0') }
    end

    context 'SpeedGov ao passar um provedor e municipio,' do
      subject do
        Rnfse::API.new(provedor: :speed_gov, 
                       municipio: :petrolina)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://ws.speedgov.com.br/') }
      its(:endpoint) { should eq('http://www.speedgov.com.br/wspet/Nfes') }
      its(:api) { should eq('speed_gov_1_0') }
    end

    context 'SpeedGov ao passar um provedor em homologação' do
      subject do
        Rnfse::API.new(provedor: :speed_gov, 
                       homologacao: true)
      end

      it { should be_kind_of(Rnfse::API) }
      its(:namespace) { should eq('http://ws.speedgov.com.br/') }
      its(:endpoint) { should eq('http://speedgov.com.br/wsmod/Nfes') }
      its(:api) { should eq('speed_gov_1_0') }
    end

  end
end
