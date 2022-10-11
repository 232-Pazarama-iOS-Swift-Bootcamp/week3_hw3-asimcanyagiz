//
//  MusicResponse.swift
//  iOS-Bootcamp-Week3
//
//  Created by Asım can Yağız on 9.10.2022.
//

import Foundation
//This section for save datas come from api
struct MusicResponse: Decodable {
    let resultCount: Int?
    let results: [Music]?
}

