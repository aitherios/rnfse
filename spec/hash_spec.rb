# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::Hash do

  describe '::transform_keys' do
    context 'com um hash simples,' do
      let(:hash) { { name: 'Rob', age: '28' } }
      let(:transformed_hash) { { 'NAME' => 'Rob', 'AGE' => '28' } }
      it { expect(Rnfse::Hash.transform_keys(hash){ |key| key.to_s.upcase}).to eq(transformed_hash) }
    end

    context 'com um hash dentro de outro,' do
      let(:hash) { { name: { first: 'Rob', last: 'Zombie' } } }
      let(:transformed_hash) { { 'NAME' => { 'FIRST' => 'Rob', 'LAST' => 'Zombie' } } }
      it { expect(Rnfse::Hash.transform_keys(hash){ |key| key.to_s.upcase}).to eq(transformed_hash) }
    end

    context 'com um array com outros objetos,' do
      let(:hash) { { names: [ { first: 'Glados' }, { first: 'Wheatley' } ] } }
      let(:transformed_hash) { { 'NAMES' => [ { 'FIRST' => 'Glados' }, { 'FIRST' => 'Wheatley' } ] } }
      it { expect(Rnfse::Hash.transform_keys(hash){ |key| key.to_s.upcase}).to eq(transformed_hash) }
    end

    context 'com um regex como valor,' do
      let(:hash) { { names: [ { first_name: 'Glados' }, { first: 'Wheatley' } ] } }
      let(:transformed_hash) { { names: [ { 'FIRST_NAME' => 'Glados' }, { first: 'Wheatley' } ] } }
      it { expect(
        Rnfse::Hash.transform_keys(hash, /first_/) { |key|
          key.to_s.upcase 
        }).to eq(transformed_hash)
      }
    end
  end

  describe '#transform_keys' do
    let(:hash) { Rnfse::Hash.new({ name: 'Rob', age: '28' }) }
    let(:transformed_hash) { { 'NAME' => 'Rob', 'AGE' => '28' } }
    it { expect(hash.transform_keys { |key| key.to_s.upcase}).to eq(transformed_hash) }
  end

  describe '::symbolize_keys' do
    let(:hash) { { 'name' => 'Rob', 'age' => '28' } }
    let(:transformed_hash) { { name: 'Rob', age: '28' } }
    it { expect(Rnfse::Hash.symbolize_keys(hash)).to eq(transformed_hash) }
  end

  describe '#symbolize_keys' do
    let(:hash) { Rnfse::Hash.new({ 'name' => 'Rob', 'age' => '28' }) }
    let(:transformed_hash) { { name: 'Rob', age: '28' } }
    it { expect(hash.symbolize_keys).to eq(transformed_hash) }
  end

  describe '#symbolize_keys!' do
    let(:hash) { Rnfse::Hash.new({ 'name' => 'Rob', 'age' => '28' }) }
    let(:transformed_hash) { { name: 'Rob', age: '28' } }
    it { expect{hash.symbolize_keys!}.to change{hash}.to(transformed_hash) }
  end

  describe '::stringify_keys' do
    let(:hash) { { name: 'Rob', age: '28' } }
    let(:transformed_hash) { { 'name' => 'Rob', 'age' => '28' } }
    it { expect(Rnfse::Hash.stringify_keys(hash)).to eq(transformed_hash) }
  end

  describe '#stringify_keys' do
    let(:hash) { Rnfse::Hash.new({ name: 'Rob', age: '28' }) }
    let(:transformed_hash) { { 'name' => 'Rob', 'age' => '28' } }
    it { expect(hash.stringify_keys).to eq(transformed_hash) }
  end

  describe '::camelize_and_symbolize_keys' do
    let(:hash) { { 'first_name' => 'Rob', 'current_age' => '28' } }
    let(:transformed_hash) { { FirstName: 'Rob', CurrentAge: '28' } }
    it { expect(Rnfse::Hash.camelize_and_symbolize_keys(hash)).to eq(transformed_hash) }
  end

  describe '#camelize_and_symbolize_keys' do
    let(:hash) { Rnfse::Hash.new({ 'first_name' => 'Rob', 'current_age' => '28' }) }
    let(:transformed_hash) { { FirstName: 'Rob', CurrentAge: '28' } }
    it { expect(hash.camelize_and_symbolize_keys).to eq(transformed_hash) }
  end

  describe '::camelize_keys' do
    let(:hash) { { 'first_name' => 'Rob', :current_age => '28' } }
    let(:transformed_hash) { { 'FirstName' => 'Rob', :CurrentAge => '28' } }
    it { expect(Rnfse::Hash.camelize_keys(hash)).to eq(transformed_hash) }
  end

  describe '#camelize_keys' do
    let(:hash) { Rnfse::Hash.new({ 'first_name' => 'Rob', :current_age => '28' }) }
    let(:transformed_hash) { { 'FirstName' => 'Rob', :CurrentAge => '28' } }
    it { expect(hash.camelize_keys).to eq(transformed_hash) }
  end

  describe '#camelize_keys!' do
    let(:hash) { Rnfse::Hash.new({ 'first_name' => 'Rob', :current_age => '28' }) }
    let(:transformed_hash) { { 'FirstName' => 'Rob', :CurrentAge => '28' } }
    it { expect{hash.camelize_keys!}.to change{hash}.to(transformed_hash) }
  end

  describe '::gsub_keys' do
    context 'with string,' do
      let(:hash) { { :cep => '12345-010', 'cep' => '12345-010' } }
      let(:transformed_hash) { { :CEP => '12345-010', 'CEP' => '12345-010' } }
      it { expect(Rnfse::Hash.gsub_keys(hash, 'cep', 'CEP')).to eq(transformed_hash) }
    end

    context 'with regex,' do
      let(:hash) { { :cep => '12345-010', 'cep' => '12345-010' } }
      let(:transformed_hash) { { :CEP => '12345-010', 'CEP' => '12345-010' } }
      it { expect(Rnfse::Hash.gsub_keys(hash, /\Acep\Z/, 'CEP')).to eq(transformed_hash) }
    end
  end

  describe '#gsub_keys' do
    let(:hash) { Rnfse::Hash.new({ :cep => '12345-010', 'cep' => '12345-010' }) }
    let(:transformed_hash) { { :CEP => '12345-010', 'CEP' => '12345-010' } }
    it { expect(hash.gsub_keys('cep', 'CEP')).to eq(transformed_hash) }
  end

  describe '#gsub_keys!' do
    let(:hash) { Rnfse::Hash.new({ :cep => '12345-010', 'cep' => '12345-010' }) }
    let(:transformed_hash) { { :CEP => '12345-010', 'CEP' => '12345-010' } }
    it { expect{hash.gsub_keys!('cep', 'CEP')}.to change{hash}.to(transformed_hash) }
  end

  describe '::underscore_and_symbolize_keys' do
    let(:hash) { { 'first_name' => 'Rob', 'currentAge' => '28' } }
    let(:transformed_hash) { { first_name: 'Rob', current_age: '28' } }
    it { expect(Rnfse::Hash.underscore_and_symbolize_keys(hash)).to eq(transformed_hash) }
  end

  describe '#underscore_and_symbolize_keys' do
    let(:hash) { Rnfse::Hash.new({ 'first_name' => 'Rob', 'currentAge' => '28' }) }
    let(:transformed_hash) { { first_name: 'Rob', current_age: '28' } }
    it { expect(hash.underscore_and_symbolize_keys).to eq(transformed_hash) }
  end

  describe '::transform_values' do
    context 'com um hash simples,' do
      let(:hash) { { name: 'Rob', age: '28' } }
      let(:transformed_hash) { { name: 'ROB', age: '28' } }
      it { expect(
        Rnfse::Hash.transform_values(hash, :name) { |val| 
          val.to_s.upcase 
        }).to eq(transformed_hash) 
      }
    end

    context 'com um hash dentro de outro,' do
      let(:hash) { { name: { first: 'Rob', last: 'Zombie' } } }
      let(:transformed_hash) { { name: { first: 'Rob', last: 'ZOMBIE' } } }
      it { expect(
        Rnfse::Hash.transform_values(hash, :last) { |val| 
          val.to_s.upcase 
        }).to eq(transformed_hash) 
      }
    end

    context 'com um hash e array com outros objetos,' do
      let(:hash) { { first: 'Aperture', names: [ { first: 'Glados' } ] } }
      let(:transformed_hash) { { first: 'APERTURE', names: [ { first: 'GLADOS' } ] } }
      it { expect(
        Rnfse::Hash.transform_values(hash, :first) { |val| 
          val.to_s.upcase 
        }).to eq(transformed_hash) 
      }
    end

    context 'com um array com outros objetos,' do
      let(:hash) { { names: [ { first: 'Glados' }, { first: 'Wheatley' } ] } }
      let(:transformed_hash) { { names: [ { first: 'GLADOS' }, { first: 'WHEATLEY' } ] } }
      it { expect(
        Rnfse::Hash.transform_values(hash, :first) { |val| 
          val.to_s.upcase 
        }).to eq(transformed_hash) 
      }
    end

    context 'com um regex como valor,' do
      let(:hash) { { names: [ { first_name: 'Glados' }, { first: 'Wheatley' } ] } }
      let(:transformed_hash) { { names: [ { first_name: 'GLADOS' }, { first: 'Wheatley' } ] } }
      it { expect(
        Rnfse::Hash.transform_values(hash, /first_/) { |val| 
          val.to_s.upcase 
        }).to eq(transformed_hash) 
      }
    end
  end

  describe '#transform_values' do
    let(:hash) { Rnfse::Hash.new({ name: 'Rob', age: '28' }) }
    let(:transformed_hash) { { name: 'ROB', age: '28' } }
    it { expect(
      hash.transform_values(:name) { |val| 
        val.to_s.upcase 
      }).to eq(transformed_hash) 
    }
  end

  describe '::replace_key_values' do
    context 'com um hash simples,' do
      let(:hash) { { name: 'Rob', age: '28' } }
      let(:transformed_hash) { { first: { name: 'Rob' }, age: '28' } }
      it { expect(
        Rnfse::Hash.replace_key_values(hash, :name) { |key, value| 
          { first: { key => value } }
        }).to eq(transformed_hash) 
      }
    end

    context 'com um hash dentro de outro,' do
      let(:hash) { { name: { first: 'Rob', last: 'Zombie' } } }
      let(:transformed_hash) { { name: { strong: { first: 'Rob' }, last: 'Zombie' } } }
      it { expect(
        Rnfse::Hash.replace_key_values(hash, :first) { |key, value| 
          { strong: { key => value } }
        }).to eq(transformed_hash) 
      }
    end

    context 'com um array com outros objetos,' do
      let(:hash) { { names: [ { first: 'Glados' }, { second: 'Wheatley' } ] } }
      let(:transformed_hash) { { names: [ { strong: { first: 'Glados' } }, { second: 'Wheatley' } ] } }
      it { expect(
        Rnfse::Hash.replace_key_values(hash, :first) { |key, value| 
          { strong: { key => value } }
        }).to eq(transformed_hash) 
      }
    end

    context 'com um regex como valor,' do
      let(:hash) { { names: [ { first_name: 'Glados' }, { second: 'Wheatley' } ] } }
      let(:transformed_hash) { { names: [ { strong: { first_name: 'Glados' } }, { second: 'Wheatley' } ] } }
      it { expect(
        Rnfse::Hash.replace_key_values(hash, /first/) { |key, value| 
          { strong: { key => value } }
        }).to eq(transformed_hash) 
      }
    end

    context 'com um escopo de tag definido' do
      let(:hash) { { names: { first: 'Glados' }, nicknames: { first: 'Wheatley' } } }
      let(:transformed_hash) { { names: { first: 'GLADOS' }, nicknames: { first: 'Wheatley' } } }

      it { expect(
        Rnfse::Hash.replace_key_values(hash, 'names/first') { |key, value| 
          { key => value.upcase }
        }).to eq(transformed_hash) 
      }
    end

    context 'com um array de regexes' do
      let(:hash) { { names: { first: 'Glados' }, nicknames: { first: 'Wheatley' } } }
      let(:transformed_hash) { { names: { first: 'GLADOS' }, nicknames: { first: 'Wheatley' } } }

      it { expect(
        Rnfse::Hash.replace_key_values(hash, [ /\Anames\Z/, /\Afirst\Z/ ]) { |key, value| 
          { key => value.upcase }
        }).to eq(transformed_hash)
      }
    end
  end

  describe '#replace_key_values' do
    let(:hash) { Rnfse::Hash.new({ name: 'Rob', age: '28' }) }
    let(:transformed_hash) { { first: { name: 'Rob' }, age: '28' } }
    it { expect(
      hash.replace_key_values(:name) { |key, value| 
        { first: { key => value } }
      }).to eq(transformed_hash) 
    }
  end

end
