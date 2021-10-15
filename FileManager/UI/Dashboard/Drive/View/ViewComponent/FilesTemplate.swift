//
//  Template.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation
import UIKit
struct FilesTemplate:ViewProtocol,Codable{
    
    
    var name:String?
    var driveHeader:FilesHeader?
    var driveStorage:FilesStorage?
    var driveSearch:FilesSearch?
    var driveFoldersContainer:FoldersContainer?
    var driveFilesContainer:FilesContainer?
    var driveFooter:FilesFooter?
    var order:Int?
    var tag: Int?
    var properties:[Properties]?
    init(name:String, header:FilesHeader? = nil, storage:FilesStorage?=nil, search:FilesSearch?=nil,driveFoldersContainer:FoldersContainer? = nil, driveFilesContainer:FilesContainer? = nil,  footer:FilesFooter? = nil,order:Int,tag:Int?=nil, properties:[Properties]? = nil)
    {
        self.name = name
        self.driveHeader = header
        self.driveStorage = storage
        self.driveFoldersContainer = driveFoldersContainer
        self.driveFilesContainer = driveFilesContainer
        self.driveFooter = footer
        self.order = order
        self.tag = tag
        self.properties = properties
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case driveStorage
        case driveHeader
        case driveSearch
        case driveFoldersContainer
        case driveFilesContainer
        case driveFooter
        case order
        case tag
        case properties
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        driveHeader = try values.decodeIfPresent(FilesHeader.self, forKey: .driveHeader)
        driveStorage = try values.decodeIfPresent(FilesStorage.self, forKey: .driveStorage)
        driveSearch = try values.decodeIfPresent(FilesSearch.self, forKey: .driveSearch)
        driveFoldersContainer = try values.decodeIfPresent(FoldersContainer.self, forKey: .driveFoldersContainer)
        driveFilesContainer = try values.decodeIfPresent(FilesContainer.self, forKey: .driveFilesContainer)
        driveFooter = try values.decodeIfPresent(FilesFooter.self, forKey: .driveFooter)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        
    }
    
    func getView()->UIView {
        
        let t = getVStack(spacing: 0,alignment: .fill, distribution: .fill)
        t.translatesAutoresizingMaskIntoConstraints = false
        
        t.tag = self.tag ?? 0
        

        let hStack = getHStack(spacing: 0,alignment: .bottom,  distribution: .fillProportionally)
        let leftViews = getVStack(spacing: 0,alignment: .fill, distribution: .fill)
        let rightView = getVStack(spacing: 0,alignment: .bottom, distribution: .fillProportionally)
        t.translatesAutoresizingMaskIntoConstraints = false
        var headerViews:[ViewProtocol] = []
        var bottomViews:[ViewProtocol] = []
        
        if let u = driveHeader {
            headerViews.append(u)
            
            
            if let _ = u.image {
                let view = UIImageView()
                view.tag = u.image?.tag ?? 0
                if let attributes =  u.image?.properties {
                    setImageProperties(image: view, properties:attributes)
                }
                rightView.addArrangedSubview(view)
            }
        }
        
        if let s = driveStorage {
            headerViews.append(s)
           
        }
        if let b = driveSearch {
            bottomViews.append(b)
            
        }
        
        if let f = driveFoldersContainer {
            bottomViews.append(f)
            
        }
        
        if let files = driveFilesContainer {
            bottomViews.append(files)
            
        }
        
        if let footer = driveFooter {
            bottomViews.append(footer)
            
        }
        
        
        
        headerViews.sort(){$0.order!<$1.order!}
        for view in headerViews {
            
            leftViews.addArrangedSubview(view.getView())
        }
        if leftViews.arrangedSubviews.count > 0 {
            hStack.addArrangedSubview(leftViews)
        }
        
        if rightView.arrangedSubviews.count > 0 {
            hStack.addArrangedSubview(rightView)
        }
        t.addArrangedSubview(hStack)
        hStack.addBackground(color: UIColor(hex: "#502EE3FF") ?? UIColor.white,borderWidth: 0.0)
//        let cornerView = UIView()
//        cornerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        cornerView.backgroundColor = UIColor(hex: "#000000FF")
//        cornerView.clipsToBounds = true
//        cornerView.layer.cornerRadius = 20
//        cornerView.layer.maskedCorners = [.layerMinXMaxYCorner]
//        t.addArrangedSubview(cornerView)
        bottomViews.sort(){$0.order!<$1.order!}
        for view in bottomViews {
            
            t.addArrangedSubview(view.getView())
        }
        if let attributes = self.properties {
            setStackProperties(stack: t, properties:attributes)
        }
        return t
    }
    
}
