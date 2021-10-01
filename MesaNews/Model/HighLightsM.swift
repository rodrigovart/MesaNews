//
//  HighLightsM.swift
//  HighLightsM
//
//  Created by MAC on 01/10/21.
//

import Foundation

struct HighLightsModel {
    struct HighLightsModelResult: Decodable {
        var data: [HighLights]
    }
}

struct HighLights: Decodable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
}
