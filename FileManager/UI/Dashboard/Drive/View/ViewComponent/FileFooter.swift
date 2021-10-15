//
//  FileFooter.swift
//  FileManager
//
//  Created by Naveen Chauhan on 15/10/21.
//

import UIKit

struct FilesFooter:ViewProtocol,Codable {
    var button:ButtonProperties?
    var order:Int?
    var tag: Int?
    var properties:[Properties]?
    init(tag:Int, order:Int){
        
        self.order = order
        self.tag = tag
        
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        button = try values.decodeIfPresent(ButtonProperties.self, forKey: .button)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    
    func getView()->UIView {
        let t = getHStack(spacing: 0,alignment: .fill, distribution: .fillProportionally)
        //let t = getZView()
        t.tag = tag ?? 0
        
        
       // t.addZSubview(view: info, position: .top)
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }
}
