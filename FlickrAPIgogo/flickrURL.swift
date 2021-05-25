//
//  flickrURL.swift
//  FlickrAPIgogo
//
//  Created by 黃肇祺 on 2021/5/24.
//

import Foundation

struct imageLink: Codable {
    var m: URL
}


struct redomImageResponse: Codable {
    var title: String
    var link: URL
    var media: imageLink
    var published: Date
}

struct imageResponse: Codable {
    var items: [redomImageResponse]
}



/* JSON資料擷取
 title": "20180904-IMG_3339-2",
 "link": "https:\/\/www.flickr.com\/photos\/139239354@N02\/46079881262\/",
 "media": {"m":"https:\/\/live.staticflickr.com\/4811\/46079881262_1a78f25789_m.jpg"},
 "date_taken": "2018-12-01T22:21:11-08:00",
 "description": " <p><a href=\"https:\/\/www.flickr.com\/people\/139239354@N02\/\">mirrorSalt<\/a> posted a photo:<\/p> <p><a href=\"https:\/\/www.flickr.com\/photos\/139239354@N02\/46079881262\/\" title=\"20180904-IMG_3339-2\"><img src=\"https:\/\/live.staticflickr.com\/4811\/46079881262_1a78f25789_m.jpg\" width=\"240\" height=\"160\" alt=\"20180904-IMG_3339-2\" \/><\/a><\/p> ",
 "published": "2018-12-01T14:21:56Z",
 "author": "nobody@flickr.com (\"mirrorSalt\")",
 "author_id": "139239354@N02",
 "tags": ""*/
