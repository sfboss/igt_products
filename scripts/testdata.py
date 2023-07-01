import requests
import json

def fetch_results(query, first=10, before=None):
    url = 'https://mobile.api.trailhead.com/graphql'
    headers = {
        'Connection': 'keep-alive',
        'Origin': 'https://trailhead.salesforce.com',
        'Referer': 'https://trailhead.salesforce.com/',
        'Sec-Fetch-Dest': 'empty',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Site': 'cross-site',
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        'accept': '*/*',
        'accept-language': 'en',
        'content-type': 'application/json',
        'sec-ch-ua': '"Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"macOS"'
    }

    variables = {
        "query": query,
        "first": first,
        "before": before
    }

    payload = {
        "operationName": "LxIndexPage",
        "variables": variables,
        "query": '''
            query LxIndexPage($query: String!, $first: Int = 10, $before: String, $after: String, $sort: SearchSort, $filter: SearchFilterInput, $searchAnalyticsPayload: String) {
              indexPageSearch(
                criteria: {text: $query, sort: $sort}
                filter: $filter
                first: $first
                before: $before
                after: $after
                searchAnalyticsPayload: $searchAnalyticsPayload
              ) {
                searchAnalyticsPayload
                totalCount
                __typename
                edges {
                  __typename
                  cursor
                  node {
                    clickAnalyticsPayload
                    learning {
                      ...Learning
                      __typename
                    }
                    __typename
                  }
                }
                pageInfo {
                  hasPreviousPage
                  hasNextPage
                  startCursor
                  endCursor
                  __typename
                }
              }
            }

            fragment Learning on LearningSummary {
              id
              type
              name
              label
              creatorName
              favorite
              description
              url
              color
              iconUrl
              pointTotal
              minuteTotal
              progress {
                ...Progress
                __typename
              }
              __typename
            }

            fragment Progress on UserProgress {
              __typename
              completedPercent
              completedDate
              earnedPoints
              state
            }
        '''
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response_json = response.json()
    print (json.dumps(response_json, indent=2))
    return response_json

def fetch_all_results(query, batch_size=10):
    results = []
    end_cursor = None
    has_next_page = True

    while has_next_page:
        response_json = fetch_results(query, first=batch_size, before=end_cursor)
        edges = response_json['data']['indexPageSearch']['edges']
        results.extend(edges)

        page_info = response_json['data']['indexPageSearch']['pageInfo']
        has_next_page = page_info['hasNextPage']
        end_cursor = page_info['endCursor']

    return results

# Example usage
query = ""  # Your search query
all_results = fetch_all_results(query)

# Process the results as needed
for result in all_results:
    # Access the result attributes
    node = result['node']
    learning = node['learning']
    # Process the learning data
    # ...
