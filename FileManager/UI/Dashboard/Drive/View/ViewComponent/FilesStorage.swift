//
//  FilesStorage.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

struct FilesStorage:ViewProtocol,Codable {
    var tag: Int?
    
    var title:TextProperties?
    var subtitle:TextProperties?
    var progress:StackProperties?
    var order:Int?
    var properties:[Properties]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case progress
        case order
        case properties
    }
    
    init(title:TextProperties? = nil, subtitle:TextProperties? = nil, progress:StackProperties? = nil, order:Int, properties:[Properties]? = nil){
        self.title = title
        self.subtitle = subtitle
        self.progress = progress
        self.order = order
        self.properties = properties
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        subtitle = try values.decodeIfPresent(TextProperties.self, forKey: .subtitle)
        progress = try values.decodeIfPresent(StackProperties.self, forKey: .progress)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    
    func getView()->UIView {
        let t = getVStack(spacing: 5, alignment: .fill,distribution: .fill)
       
        
        t.tag = order ?? 0
       
        //let t = getZView()
       
        let h = getHStack(spacing: 5, alignment: .leading,distribution: .fillProportionally)
        
        if let storageLbl = title {
            let titleLbl = getLabel()
            titleLbl.tag = storageLbl.tag ?? 0
            
            h.addArrangedSubview(titleLbl)
            if let attributes = title?.properties {
                setTextProperties(label: titleLbl, properties: attributes)
                
            }
            
        }
        
        
        
        if let totalSpaceLbl = subtitle {
            let subtitleLbl = getLabel()
            subtitleLbl.tag = totalSpaceLbl.tag  ?? 0
            h.addArrangedSubview(subtitleLbl)
            if let attributes = totalSpaceLbl.properties {
                setTextProperties(label: subtitleLbl, properties: attributes)
            }
        }
        if h.arrangedSubviews.count > 0 {
            t.addArrangedSubview(h)
        }
       
        
        if let progressBar = progress {
            let stack = getHStack(spacing:0,alignment:.fill, distribution:.fill)
            stack.tag = progressBar.tag ?? 0
//            let subtitleLbl = getLabel()
//            subtitleLbl.text = text
//            stack.addArrangedSubview(subtitleLbl)
            
            t.addArrangedSubview(stack)
            
            NSLayoutConstraint.activate([
            
            ])
            if let attributes = progress?.properties {
                setStackProperties(stack: stack, properties: attributes)
               
            }
        }
        
       // t.addZSubview(view: info, position: .top)
        
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        return t
    }
}
