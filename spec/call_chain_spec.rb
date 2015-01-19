# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::CallChain do
  
  # for the usage in tests where methods are chained like:
  # instance_method_c calls instance_method_b calls instance_method_a
  class KlassA
    def self.class_method_a(d = 1)
      Rnfse::CallChain.caller_method(d)
    end
    
    def self.class_method_b(d = 1)
      self.class_method_a(d)
    end

    def self.class_method_c(d = 1)
      self.class_method_b(d)
    end

    def instance_method_a(d = 1)
      Rnfse::CallChain.caller_method(d)
    end

    def instance_method_b(d = 1)
      instance_method_a(d)
    end

    def instance_method_c(d = 1)
      instance_method_b(d)
    end
  end

  describe '::caller_method' do
    let(:object) { KlassA.new }
    let(:klass) { KlassA }

    it 'should return depth 1 (previous) caller method' do
      expect(object.instance_method_b).to eq('instance_method_b')
      expect(object.instance_method_c).to eq('instance_method_b')
      expect(klass.class_method_b).to eq('class_method_b')
      expect(klass.class_method_c).to eq('class_method_b')
    end

    it 'should return depth 2 (before previous) caller method' do
      expect(object.instance_method_c(2)).to eq('instance_method_c')
      expect(klass.class_method_c(2)).to eq('class_method_c')
    end
  end
end
