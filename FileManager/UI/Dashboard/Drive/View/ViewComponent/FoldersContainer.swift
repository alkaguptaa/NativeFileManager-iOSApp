//
//  Scroll.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation
import UIKit

struct FoldersContainer:ViewProtocol,Codable{
    var title:TextProperties?
    var viewAll:TextProperties?
    var horizontalBar:ScrollBarProperties?
   
    var scroll:[FolderElement]?
    var order:Int?
    var tag:Int?
    var properties:[Properties]?
    init(tag:Int ,order:Int){
       
        self.order = order
        self.tag = tag
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        viewAll = try values.decodeIfPresent(TextProperties.self, forKey: .viewAll)
        scroll = try values.decodeIfPresent([FolderElement].self, forKey: .scroll)
        horizontalBar = try values.decodeIfPresent(ScrollBarProperties.self, forKey: .horizontalBar)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    func getView()->UIView {
        let t = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.tag = tag ?? 0
        
        if let titleProperties = title {
            let titleLbl = getLabel()
            
            titleLbl.text = titleProperties.text ?? ""
            titleLbl.tag = titleProperties.tag ?? 0
            t.addArrangedSubview(titleLbl)
            if let attributes = title?.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
            
        }
        
        if let bar = horizontalBar {
            let container = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
            container.translatesAutoresizingMaskIntoConstraints = false
            container.tag = bar.tag ?? 0
            
            
            t.addArrangedSubview(container)
        }else if let scrl = scroll {
            let container = getVStack(spacing: 0, alignment:.fill,distribution: .fill)
            container.translatesAutoresizingMaskIntoConstraints = false
            
            let s = UIScrollView()
            s.showsHorizontalScrollIndicator = false
            s.translatesAutoresizingMaskIntoConstraints = false
            container.addArrangedSubview(s)
            
            
            let hScroll = getHStack(spacing: 10,alignment: .fill, distribution: .fillEqually)
            hScroll.translatesAutoresizingMaskIntoConstraints = false
            var contentSize:CGFloat = 0.0
            for ele in scrl {
                hScroll.addArrangedSubview(ele.getView())
                contentSize+=112.0
            }
            s.addSubview(hScroll)
            s.contentSize = CGSize(width:contentSize,height: hScroll.frame.height)
            
            
            NSLayoutConstraint.activate([
                s.leftAnchor.constraint(equalTo: container.leftAnchor),
                s.rightAnchor.constraint(equalTo: container.rightAnchor),
                s.topAnchor.constraint(equalTo: container.topAnchor),
                s.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                hScroll.heightAnchor.constraint(equalTo: s.heightAnchor),
                hScroll.leadingAnchor.constraint(equalTo: s.leadingAnchor),
                hScroll.centerYAnchor.constraint(equalTo: s.centerYAnchor),
            ])
            t.addArrangedSubview(container)
        }
       
        
        
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        return t
    }
}

struct FolderElement:ViewProtocol,Codable{
    var tag: Int?
    
    var image:ImagePropterties?
    var title:TextProperties?
    var path:String?
    var order:Int?
    var properties:[Properties]?
    init(image:ImagePropterties? = nil, title: TextProperties? = nil, path:String?=nil, order:Int, properties:[Properties]?=nil){
        self.image = image
        self.title = title
        self.path = path
        self.order  = order
        self.properties = properties
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self)
        image = try values.decodeIfPresent(ImagePropterties.self, forKey: .image)
        title = try values.decodeIfPresent(TextProperties.self, forKey: .title)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    func getView()->UIView {
        let template = getVStack(spacing: 0,alignment: .fill, distribution: .fill)
        template.translatesAutoresizingMaskIntoConstraints = false
       
        if let imageProp = image {
            let hStack = getHStack(spacing: 0,alignment: .center, distribution: .fill)
            
            let view = UIView()
            let imgView = getImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            if let resource = imageProp.resource, let img = UIImage(named: resource) {
                imgView.image = img
            }
            view.addSubview(imgView)
            template.addArrangedSubview(view)
            if let attributes = imageProp.properties {
                setImageProperties(image: imgView, properties: attributes)
            }
            NSLayoutConstraint.activate([
                imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
            hStack.addArrangedSubview(view)
            template.addArrangedSubview(hStack)
            if let bgColor = UIColor(hex: "#CCCCCCCC") {
                hStack.addBackground(color: bgColor)
            }
            
        }
        
        if let titleProp = title {
            let titleLbl = getLabel()
            titleLbl.text = titleProp.text ?? ""
            template.addArrangedSubview(titleLbl)
            if let attributes = titleProp.properties {
                setTextProperties(label: titleLbl, properties: attributes)
            }
            
        }
        
        if let attributes = self.properties {
            setStackProperties(stack: template, properties:attributes)
        }
        
        return template
    }
}

