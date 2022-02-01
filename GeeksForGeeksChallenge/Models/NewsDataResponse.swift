//
//  NewsDataResponse.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation

struct NewsDataResponse : Codable {
	let status : String?
	let feed : Feed?
	let newsItems : [NewsItem]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case feed = "feed"
		case newsItems = "items"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
        newsItems = try values.decodeIfPresent([NewsItem].self, forKey: .newsItems)
	}

}
