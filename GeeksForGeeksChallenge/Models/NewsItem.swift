//
//  NewsItem.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//


import Foundation

struct NewsItem : Codable {
	let title : String?
	let pubDate : Date?
	let link : String?
	let guid : String?
	let author : String?
	let thumbnail : String?
	let description : String?
	let content : String?
	let enclosure : Enclosure?
	let categories : [String]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case pubDate = "pubDate"
		case link = "link"
		case guid = "guid"
		case author = "author"
		case thumbnail = "thumbnail"
		case description = "description"
		case content = "content"
		case enclosure = "enclosure"
		case categories = "categories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		pubDate = try values.decodeIfPresent(Date.self, forKey: .pubDate)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		guid = try values.decodeIfPresent(String.self, forKey: .guid)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		enclosure = try values.decodeIfPresent(Enclosure.self, forKey: .enclosure)
		categories = try values.decodeIfPresent([String].self, forKey: .categories)
	}

}
