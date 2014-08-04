# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rnfse::Error do

  it { expect(Rnfse::Error::NotImplemented.ancestors).to include(NotImplementedError) }
  it { expect(Rnfse::Error::BetterNotBeUsed.ancestors).to include(StandardError) }

end
