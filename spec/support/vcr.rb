# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join('spec/vcr')
  config.configure_rspec_metadata!
  config.hook_into :webmock
end
