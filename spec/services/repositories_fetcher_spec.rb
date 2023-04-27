# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoriesFetcher, type: :service do
  describe '.call' do
    subject { described_class.call(search_term, options) }

    let(:search_term) { 'octokit' }
    let(:options) { {} }
    let(:fetcher_response_keys) { %i[repositories total_count error_message] }

    context 'when only search key was provided', vcr: { cassette_name: 'services/repositories/default_request' } do
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
    end

    context 'when sorting params are provided' do
      describe 'sort in desc order', vcr: { cassette_name: 'services/repositories/sort_in_desc_order' } do
        let(:options) { { sort: 'stars', order: 'desc' } }
        let(:stars) { subject[:repositories].map { |r| r['stargazers_count'] } }

        let(:repositories_names) do
          [
            'octokit.js',
            'octokit.rb',
            'octokit.net',
            'octokit.objc',
            'Monkey',
            'octokit.swift',
            'fork-sync',
            'go-octokit',
            'github-metadata',
            'Github.swift',
            'CodeHub',
            'octokit.graphql.net',
            'GithubSharp',
            'types.ts',
            'octokit-plugin-create-pull-request',
            'plugin-throttling.js',
            'plugin-rest-endpoint-methods.js',
            'githubkit',
            'minisauras',
            'octokit.py',
            'end_of_life',
            'webhooks.net',
            'plugin-paginate-rest.js',
            'octokit.py',
            'openapi',
            'korefile',
            'RequestKit',
            'octokit-plugin-config',
            'fixtures-server',
            'octokit-commit-multiple-files'
          ]
        end

        it 'returns response according to sorting criterias' do
          expect(subject[:repositories].map { |r| r['name'] }).to match_array(repositories_names)
          expect(stars).to eq(stars.sort.reverse)
        end
      end

      describe 'sort in asc order', vcr: { cassette_name: 'services/repositories/sort_in_asc_order' } do
        let(:options) { { sort: 'stars', order: 'asc' } }
        let(:stars) { subject[:repositories].map { |r| r['stargazers_count'] } }

        let(:repositories_names) do
          ['spawncamping-octo-wookie',
           'octokit-request-browser-test',
           'octokitpy-feedstock',
           'octokit-enterprise-bug',
           'octokit-octokit.js',
           'TestOctoRepo',
           'octokit',
           'Octokit',
           'Octokit',
           'OctoKit',
           'Octokit',
           'octokit',
           'hn19802',
           'CodePlex2GitHub',
           'OctoKit.RxSwift',
           'test-octokit',
           'angular-octokit',
           'OctoKit',
           'Octokit',
           'octokit',
           'Octokit',
           'octokit',
           'hn19801',
           'GitAPItest',
           'hn1980',
           'octokit-test',
           'octokit',
           'OctoKit',
           'pry-octokit',
           'octokit-test']
        end

        it 'returns response according to sorting criterias' do
          expect(subject[:repositories].map { |r| r['name'] }).to match_array(repositories_names)
          expect(stars).to eq(stars.sort)
        end
      end
    end

    # TODO: Add more tests here e.g. validation of the input values, additional criterias, more test cases
  end
end
