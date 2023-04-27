# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoriesFetcher, type: :service, vcr: { cassette_name: 'services/repositories_fetcher' } do
  describe '.call' do
    subject { described_class.call(search_term) }

    let(:search_term) { 'octokit' }
    let(:fetcher_response_keys) { %i[repositories total_count error_message] }
    let(:repositories_names) do
      ['octokit.js',
       'octokit.rb',
       'octokit.net',
       'octokit.objc',
       'octokit.swift',
       'go-octokit',
       'GithubSharp',
       'octokit.graphql.net',
       'types.ts',
       'octokit.py',
       'octokit-plugin-create-pull-request',
       'plugin-throttling.js',
       'github-metadata',
       'plugin-enterprise-server.js',
       'octokit.py',
       'octokit-plugin-config',
       'octokit-oauth-demo',
       'plugin-rest-endpoint-methods.js',
       'RequestKit',
       'plugin-paginate-rest.js',
       'community_management',
       'ScriptCs.OctokitLibrary',
       'Octokit-lite',
       'fixtures-server',
       'create-octokit-project.js',
       'openapi',
       'octokit-auth-probot',
       'Github.swift',
       'plugin-retry.js',
       'fork-sync']
    end

    it 'returns default response from github API' do
      expect(subject).to be_a(Hash)
      expect(subject.keys).to match_array(fetcher_response_keys)
      expect(subject[:repositories].map { |r| r['name'] }).to match_array(repositories_names)
    end

    # TODO: Add more tests here
  end
end
