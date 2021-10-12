//
//  DriveViewModel.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

struct File:Codable{
    var image:ImagePropterties?
    var isFolder:Bool?
    var title:TextProperties?
    var size:TextProperties?
    var path:String?
    var order:Int?
    var properties:[Properties]?
    init(image:ImagePropterties? = nil, title: TextProperties? = nil,size:TextProperties? = nil, path:String?=nil,isFolder:Bool?=nil, order:Int, properties:[Properties]?=nil){
        self.image = image
        self.title = title
        self.path = path
        self.order  = order
        self.properties = properties
        self.size = size
        self.isFolder = isFolder
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey: .image)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        size = try values.decodeIfPresent(TextProperties.self, forKey: .size)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        isFolder = try values.decodeIfPresent(Bool.self, forKey: .isFolder)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
}

struct JsonData: Codable {
    var results: [File]
}
