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
class File{
    var id : String! = UUID().uuidString
     var name : String?
    var Key_name : String?
    var human_size : String?
   var lastModified : String?
    var size : String?
    var ext : String?
    var isDirectory : Bool = false
    var thumbnailImage : Data? = nil
    
    init(name:String? = nil,ext:String? = nil, size:String? = nil){
        self.name = name
        self.ext = ext
        self.size = size
    }
    required init(from decoder: Decoder) throws {
       
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        
        Key_name = try values.decodeIfPresent(String.self, forKey: .Key_name)
        human_size = try values.decodeIfPresent(String.self, forKey: .human_size)
                
        
        lastModified = try values.decodeIfPresent(String.self, forKey: .lastModified)
        
        
        if let s  = try? values.decodeIfPresent(Int.self, forKey: .size) {
            size = String(s)
        }else{
            size = try values.decodeIfPresent(String.self, forKey: .size)
        }

        if let e = try values.decodeIfPresent(String.self, forKey: .ext) {
            self.ext = e
            if ext == "Collection"{
                self.isDirectory = true
                
            }
        }
    }
    
    }
    
    
extension File:Codable{
    enum CodingKeys: String, CodingKey {

        case name = "name"
        case ext = "ext"
        case Key_name = "Key_name"
        case human_size = "human_size"
        case size = "size"
        case lastModified = "lastModified"
        
        
    }
    
}

struct JsonData: Codable {
    var results: [File]
}
