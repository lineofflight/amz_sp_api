=begin
#Selling Partner API for Sellers

#The [Selling Partner API for Sellers](https://developer-docs.amazon.com/sp-api/docs/sellers-api-v1-reference) (Sellers API) provides essential information about seller accounts, such as:  - The marketplaces a seller can list in - The default language and currency of a marketplace - Whether the seller has suspended listings  Refer to the [Sellers API reference](https://developer-docs.amazon.com/sp-api/docs/sellers-api-v1-reference) for details about this API's operations, data types, and schemas.

OpenAPI spec version: v1

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.61
=end

require 'spec_helper'
require 'json'
require 'date'

# Unit tests for AmzSpApi::SellersApiModel::Participation
# Automatically generated by swagger-codegen (github.com/swagger-api/swagger-codegen)
# Please update as you see appropriate
describe 'Participation' do
  before do
    # run before each test
    @instance = AmzSpApi::SellersApiModel::Participation.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of Participation' do
    it 'should create an instance of Participation' do
      expect(@instance).to be_instance_of(AmzSpApi::SellersApiModel::Participation)
    end
  end
  describe 'test attribute "is_participating"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

  describe 'test attribute "has_suspended_listings"' do
    it 'should work' do
      # assertion here. ref: https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end
  end

end
