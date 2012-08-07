#! /usr/bin/env ruby -S rspec

require 'spec_helper'

describe "the to_bytes function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("to_bytes").should == "function_to_bytes"
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    lambda { scope.function_to_bytes([]) }.should( raise_error(Puppet::ParseError))
  end

  it "should convert kB to B" do
    result = scope.function_to_bytes(["4 kB"])
    result.should(eq(4096))
  end

  it "should work without B in unit" do
    result = scope.function_to_bytes(["4 k"])
    result.should(eq(4096))
  end

  it "should work without a space before unit" do
    result = scope.function_to_bytes(["4k"])
    result.should(eq(4096))
  end

  it "should work without a unit" do
    result = scope.function_to_bytes(["5678"])
    result.should(eq(5678))
  end

  it "should convert fractions" do
    result = scope.function_to_bytes(["1.5 kB"])
    result.should(eq(1536))
  end

  it "should do nothing with a positive number" do
    result = scope.function_to_bytes([5678])
    result.should(eq(5678))
  end

  it "should should return 0 if input isn't a number" do
    result = scope.function_to_bytes(["foo"])
    result.should(eq(0))
  end
end
