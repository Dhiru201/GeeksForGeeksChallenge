//
//  APIService.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation

protocol APIServiceProtocol {
    func fetchNewsFeeds() async throws -> [NewsItem]?
}

private let sessionManager: URLSession = {
    let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
}()

class APIService: APIServiceProtocol {
    
    enum NewsFetcherError: Error {
            case invalidURL
            case missingData
        }
    // fetch data from Server
    func fetchNewsFeeds() async throws -> [NewsItem]? {
        
        guard let url = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml") else {
            throw NewsFetcherError.invalidURL
        }
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let responseModel = try jsonDecoder.decode(NewsDataResponse.self, from: data)
        return responseModel.newsItems
    }
}
