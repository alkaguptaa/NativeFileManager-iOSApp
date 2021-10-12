//
//  FilesSearch.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

struct FilesSearch:ViewProtocol,Codable {
    var title:TextProperties?
    var icon:ImagePropterties?
    var searchHeight:CGFloat?
    var containerWidth:CGFloat?
    var order:Int?
    var tag: Int?
    var properties:[Properties]?
    init(tag:Int, order:Int){
        
        self.order = order
        self.tag = tag
       
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        icon = try values.decodeIfPresent(ImagePropterties.self, forKey: .icon)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        
        searchHeight = try values.decodeIfPresent(CGFloat.self, forKey: .searchHeight)
        containerWidth = try values.decodeIfPresent(CGFloat.self, forKey: .containerWidth)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            UIRectFill(rect)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
    
    func getView()->UIView {
        let t = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
        t.tag = self.tag ?? 0
        
        
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        //t.addColors(colors: [UIColor.blue, UIColor.yellow  ])
        if let width = containerWidth {
            t.addStackColors(colors: [UIColor(hex: "#502EE3FF") ?? UIColor.white, UIColor.white], bounds: CGRect(x: 0, y: 0, width: width, height: searchHeight!))
        }
        
        return t
    }
}
