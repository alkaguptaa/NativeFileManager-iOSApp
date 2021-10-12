//
//  UserCard.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation
import UIKit

struct FilesHeader:ViewProtocol,Codable {
    var title:TextProperties?
    var subtitle:TextProperties?
    var image:ImagePropterties?
    var order:Int?
    var tag: Int?
    var properties:[Properties]?
    init(title:TextProperties? = nil, subtitle:TextProperties? = nil, image:ImagePropterties? = nil, order:Int,tag:Int? = nil, properties:[Properties]? = nil){
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.order = order
        self.tag = tag
        self.properties = properties
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        subtitle = try values.decodeIfPresent(TextProperties.self, forKey: .subtitle)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey: .image)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    
    func getView()->UIView {
        let t = getVStack(spacing: 0,alignment: .leading, distribution: .fill)
        //let t = getZView()
        t.tag = tag ?? 0
        if let titleProp = title {
            let titleLbl = getLabel()
            titleLbl.tag = titleProp.tag ?? 0
            titleLbl.numberOfLines = 0
            titleLbl.sizeToFit()
            
            t.addArrangedSubview(titleLbl)
            if let attributes = title?.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
        }
        
        if let sub = subtitle {
            let subtitleLbl = getLabel()
            subtitleLbl.numberOfLines = 0
            subtitleLbl.tag = sub.tag ?? 0
            subtitleLbl.sizeToFit()
           
            t.addArrangedSubview(subtitleLbl)
            if let attributes = subtitle?.properties {
                setTextProperties(label: subtitleLbl, properties: attributes)
            }
        }
        
       // t.addZSubview(view: info, position: .top)
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }
}
