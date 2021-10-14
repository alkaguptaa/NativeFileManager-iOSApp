//
//  Movie.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/08.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct FileApiResponse {
    let status : String?
    let data : [File]?
   
}

extension FileApiResponse: Codable {
    
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([File].self, forKey: .data)
        
    }
}


