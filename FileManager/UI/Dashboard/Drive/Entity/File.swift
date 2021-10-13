//
//  DriveViewModel.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit
public enum FileType:String {
    case Directory = "directory"
    case PDF = "pdf"
    case Image = "image"
}
struct File:Codable{
    var image:ImagePropterties?
    var type:String?
    var title:TextProperties?
    var size:TextProperties?
    var path:String?
    var order:Int?
    var properties:[Properties]?
    init(image:ImagePropterties? = nil, title: TextProperties? = nil,size:TextProperties? = nil, path:String?=nil,type:String?=nil, order:Int, properties:[Properties]?=nil){
        self.image = image
        self.title = title
        self.path = path
        self.order  = order
        self.properties = properties
        self.size = size
        self.type = type
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey: .image)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        size = try values.decodeIfPresent(TextProperties.self, forKey: .size)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
}

struct JsonData: Codable {
    var results: [File]
}
