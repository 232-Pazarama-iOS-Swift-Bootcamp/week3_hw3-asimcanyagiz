//
//  MovieResponse.swift
//  iOS-Bootcamp-Week3
//
//  Created by Asım can Yağız on 9.10.2022.
//

import Foundation
//This section for save datas come from api
struct MovieResponse: Decodable {
    let resultCount: Int?
    let results: [Movie]?
}

