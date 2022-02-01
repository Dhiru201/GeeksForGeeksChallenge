//
//  Enclosure.swift
//  GeeksForGeeksChallenge
//
//  Created by Dhirendra Verma on 01/02/22.
//

import Foundation
struct Enclosure : Codable {
	let link : String?
	let type : String?
	let thumbnail : String?

	enum CodingKeys: String, CodingKey {

		case link = "link"
		case type = "type"
		case thumbnail = "thumbnail"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
	}

}
