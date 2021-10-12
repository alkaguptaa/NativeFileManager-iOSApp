//
//  Properties.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation


struct TextProperties:Codable {
    var text:String?
    var tag:Int?
    var properties:[Properties]?
    init(text: String? = nil,tag:Int? = nil,
             properties: [Properties]? = nil) {
            
            self.text = text
            self.tag = tag
            self.properties = properties
            
        }
    enum CodingKeys: String, CodingKey {
        case text = "name"
        case properties = "properties"
       case tag = "tag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey:.properties)
        
        
    }
}

struct ScrollBarProperties:Codable {
    
    var itemProperties:[Properties]?
    var image:ImagePropterties?
    var title:TextProperties?
    var tag:Int?
    var properties:[Properties]?
    init(itemProperties:[Properties]?=nil,title:TextProperties?=nil,image:ImagePropterties?=nil, tag:Int? = nil,
        properties: [Properties]? = nil) {
        self.tag = tag
        
        self.itemProperties = itemProperties
        self.image = image
        self.title = title
        self.properties = properties
            
        }
    enum CodingKeys: String, CodingKey {
       case properties = "properties"
        case tag = "tag"
        case itemProperties = "itemProperties"
        case image = "image"
        case title = "title"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey:.properties)
        itemProperties = try values.decodeIfPresent([Properties].self, forKey:.itemProperties)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey:.image)
        title = try values.decodeIfPresent(TextProperties.self, forKey:.title)
        
    }
}

struct TableViewProperties:Codable {
    
    var itemProperties:[Properties]?
    var image:ImagePropterties?
    var title:TextProperties?
    var subtitle:TextProperties?
    var tag:Int?
    var properties:[Properties]?
    init(itemProperties:[Properties]?=nil,title:TextProperties?=nil,subtitle:TextProperties?=nil,image:ImagePropterties?=nil, tag:Int? = nil,
        properties: [Properties]? = nil) {
        self.tag = tag
        
        self.itemProperties = itemProperties
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.properties = properties
            
        }
    enum CodingKeys: String, CodingKey {
       case properties = "properties"
        case tag = "tag"
        case itemProperties = "itemProperties"
        case image = "image"
        case title = "title"
        case subtitle = "subtitle"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey:.properties)
        itemProperties = try values.decodeIfPresent([Properties].self, forKey:.itemProperties)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey:.image)
        title = try values.decodeIfPresent(TextProperties.self, forKey:.title)
        subtitle = try values.decodeIfPresent(TextProperties.self, forKey:.subtitle)
        
    }
}


struct StackProperties:Codable {
    var text:String?
    var tag:Int?
    var properties:[Properties]?
    init(text: String? = nil,tag:Int? = nil,
             properties: [Properties]? = nil) {
        self.tag = tag
            self.text = text
            self.properties = properties
            
        }
    enum CodingKeys: String, CodingKey {
        case text = "name"
        case properties = "properties"
        case tag = "tag"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey:.properties)
        
        
    }
}


struct ImagePropterties:Codable {
    var url:String?
    var resource:String?
    var tag:Int?
    var properties:[Properties]?
    init(url: String? = nil,resource: String? = nil,tag:Int? = nil,
             properties: [Properties]? = nil) {
            
            self.url = url
            self.resource = resource
            self.properties = properties
        self.tag = tag
            
        }
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case resource = "resource"
        case properties = "properties"
        case tag = "tag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        resource = try values.decodeIfPresent(String.self, forKey: .resource)
        properties = try values.decodeIfPresent([Properties].self, forKey:.properties)
        
        
    }
}

struct Properties:Codable {
    var attr:String?
    var value:String?
    init(attr:String, value:String){
        self.attr = attr
        self.value = value
    }
    enum CodingKeys: String, CodingKey {
        case attr = "attr"
        case value = "value"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attr = try values.decodeIfPresent(String.self, forKey: .attr)
        value = try values.decodeIfPresent(String.self, forKey:.value)
        
        
    }
}
