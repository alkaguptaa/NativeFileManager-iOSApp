//
//  FilesContainer.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

struct FilesContainer:ViewProtocol,Codable{
    var tag: Int?
    
    var table:TableViewProperties?
    var title:TextProperties?
    var viewAll:TextProperties?
    var order:Int?
    var properties:[Properties]?
    init(tag:Int? = nil, table:TableViewProperties? = nil,title:TextProperties? = nil,viewAll:TextProperties? = nil,order:Int, properties:[Properties]?=nil){
        self.title = title
        self.viewAll = viewAll
        self.order = order
        self.properties = properties
        self.title = title
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        viewAll = try values.decodeIfPresent(TextProperties.self, forKey: .viewAll)
        
        table = try values.decodeIfPresent(TableViewProperties.self, forKey: .table)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    
    func getView()->UIView{
        let t = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
        t.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        if let titleProp = title {
            let titleLbl = getLabel()
            titleLbl.text = titleProp.text ?? ""
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            t.addArrangedSubview(titleLbl)
            if let attributes = titleProp.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
            
        }
        
        let container = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
        container.tag = self.table?.tag ?? 0
        container.translatesAutoresizingMaskIntoConstraints = false
        
        t.addArrangedSubview(container)
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        return t
    }
}

struct FileElement:ViewProtocol,Codable{
    var image:ImagePropterties?
    var title:TextProperties?
    var size:TextProperties?
    var path:String?
    var order:Int?
    var tag:Int?
    var properties:[Properties]?
    init(image:ImagePropterties? = nil, title: TextProperties? = nil,size:TextProperties? = nil, path:String?=nil, order:Int,  tag:Int? = nil,properties:[Properties]?=nil){
        self.image = image
        self.title = title
        self.path = path
        self.order  = order
        self.properties = properties
        self.size = size
        self.tag = tag
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey: .image)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        size = try values.decodeIfPresent(TextProperties.self, forKey: .size)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        order = try values.decodeIfPresent(Int.self, forKey: .order)

        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    func getView()->UIView {
        let template = getVStack(spacing: 0,alignment: .fill, distribution: .fill)
        template.translatesAutoresizingMaskIntoConstraints = false
        let hStack = getHStack(spacing: 5, distribution: .fill)
        let vStack = getVStack(spacing: 3,alignment: .fill, distribution: .fill)
        if let name = image?.resource {
            
            let view = UIView()
            let imgView = getImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            if let img = UIImage(named: name) {
                imgView.image = img
            }
            view.addSubview(imgView)
            hStack.addArrangedSubview(view)
            
            NSLayoutConstraint.activate([
                imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            
            if let attributes = image?.properties {
                setImageProperties(image: imgView, properties: attributes)
            }
            NSLayoutConstraint.activate([
                imgView.leadingAnchor.constraint(equalTo: hStack.leadingAnchor, constant: 5.0),
                imgView.centerYAnchor.constraint(equalTo: hStack.centerYAnchor),
            ])
            
            if let bgColor = UIColor(hex: "#CCCCCCCC") {
                hStack.addBackground(color: bgColor, borderWidth: 0)
            }
            
        }
        
        if let val = title?.text {
            let titleLbl = getLabel()
            titleLbl.text = val
            vStack.addArrangedSubview(titleLbl)
            if let attributes = title?.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
            vStack.addArrangedSubview(titleLbl)
        }
        
        if let val = size?.text {
            let titleLbl = getLabel()
            titleLbl.text = val
            vStack.addArrangedSubview(titleLbl)
            if let attributes = size?.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
            vStack.addArrangedSubview(titleLbl)
        }
        hStack.addArrangedSubview(vStack)
        
        template.addArrangedSubview(hStack)
        
        if let attributes = self.properties {
            setStackProperties(stack: template, properties:attributes)
        }
        
        return template
    }
}



