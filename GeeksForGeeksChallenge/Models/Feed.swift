//
//  Feed.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation
struct Feed : Codable {
	let url : String?
	let title : String?
	let link : String?
	let author : String?
	let description : String?
	let image : String?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case title = "title"
		case link = "link"
		case author = "author"
		case description = "description"
		case image = "image"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image = try values.decodeIfPresent(String.self, forKey: .image)
	}

}
