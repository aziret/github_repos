# Thoughts on how to continue the logic:
1. Github allows sorting and pagination https://docs.github.com/en/rest/search?apiVersion=2022-11-28#search-repositories
- we can use `sort`, `order`, `per_page` and `page` params, to further refine the app
- `sort` is partially covered

2. Github allows narrowing the results using the repository search qualifiers in any combination https://docs.github.com/en/search-github/searching-on-github/searching-for-repositories
- we can use those qualifiers to make our search more specific

3. Cache our search results, to make less requests to the API

4. Need to add more test cases, add input validations