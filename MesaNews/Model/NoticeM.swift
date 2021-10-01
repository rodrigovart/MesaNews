//
//  NoticeM.swift
//  NoticeM
//
//  Created by MAC on 28/09/21.
//

import Foundation

struct NewsModel {
    struct NewsModelSend: Encodable {
        var current_page: Int
        var per_page: Int
        var published_at: String?
    }
    struct NewsModelResult: Decodable {
        var pagination: Pagination?
        var data: [News]
    }
}

struct News: Decodable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
}

struct Pagination: Decodable {
    var current_page: Int
    var per_page: Int
    var total_pages: Int
    var total_items: Int
}
