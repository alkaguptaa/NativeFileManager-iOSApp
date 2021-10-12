//
//  FileListTemplate.swift
//  FileManager
//
//  Created by Naveen Chauhan on 12/10/21.
//

import UIKit

class FileListTemplate: NSObject {

    static func getSubTemplateHeader()->FilesHeader{
        var driveHeader = FilesHeader(tag:10,order:1)
        driveHeader.title = TextProperties()
        driveHeader.title?.tag = 11
        driveHeader.title?.text = "FileManager Drive"
        driveHeader.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.fontWeight.rawValue, value: "700.0"),
            Properties(attr: Attributes.fontSize.rawValue, value: "24.0"),
           
            
            Properties(attr: Attributes.fontFamily.rawValue, value: "Metropolis-Regular")
        ]
        
        driveHeader.subtitle = TextProperties()
        driveHeader.subtitle?.tag = 12
        driveHeader.subtitle?.text = "Documents in the FileManager Drive are Not treated as authentic"
        driveHeader.subtitle?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.fontSize.rawValue, value: "14.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular"),
                
            ]
        
        driveHeader.image = ImagePropterties()
        driveHeader.image?.resource = "file-header"
        driveHeader.image?.tag = 13
        driveHeader.image?.properties = [
        Properties(attr: Attributes.contentMode.rawValue, value: "aspectFit"),
           
        ]
        driveHeader.properties = [
            Properties(attr: Attributes.margin.rawValue, value: "24,44,0,0")
        ]
        

        return driveHeader
    }
    
    static func getSubTemplateStorage()->FilesStorage{
        var driveStorage = FilesStorage(tag: 20, order: 2)
        driveStorage.title = TextProperties()
        driveStorage.subtitle = TextProperties()
        driveStorage.progress = StackProperties()
        
        driveStorage.progress?.text = "40"
        driveStorage.progress?.tag = 23
        
        driveStorage.title?.text = "982 MB"
        driveStorage.title?.tag = 21
        driveStorage.subtitle?.text = "Free of 1GB"
        driveStorage.subtitle?.tag = 22
        driveStorage.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFfFFFFF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
        ]
        
        driveStorage.subtitle?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFCC"),
            Properties(attr: Attributes.fontSize.rawValue, value: "15.0"),
            
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-SemiBold"),
           
        ]
        
        driveStorage.progress?.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#000000FF"),
            //Properties(attr: Attributes.width.rawValue, value: "295"),
            Properties(attr: Attributes.height.rawValue, value: "4")
            
            
        ]
        
        driveStorage.properties = [
            Properties(attr: Attributes.margin.rawValue, value: "24,0,0,10")
        ]
        
        
        
        return driveStorage
    }

    static func getSubTemplateSearch(frame:CGRect)->FilesSearch{
        var driveSearch = FilesSearch(tag:30,order:3)
        driveSearch.searchHeight = 60.0
        driveSearch.containerWidth = frame.width
        driveSearch.icon = ImagePropterties()
        driveSearch.title = TextProperties()
        driveSearch.tag = 31
        driveSearch.title?.text = "search for documents"
        
        driveSearch.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#FFFFFFCC"),
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
           
        ]
        driveSearch.icon?.resource = "user"
        
        driveSearch.properties = [
           Properties(attr: Attributes.leftRightMargin.rawValue, value: "24"),
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
        ]
        return driveSearch
    }
    
    
    static func getSubTemplateFolders()->FoldersContainer{
        var driveFoldersContainer = FoldersContainer(tag:40,order: 4)
        driveFoldersContainer.title = TextProperties(tag: 41,text: "Folders")
        
        driveFoldersContainer.horizontalBar = ScrollBarProperties(tag:42)
        
        driveFoldersContainer.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#000000FF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.bottomPadding.rawValue, value: "5.0")
        ]
       
        driveFoldersContainer.horizontalBar?.itemProperties = [
            Properties(attr: Attributes.width.rawValue, value: "104"),
            Properties(attr: Attributes.height.rawValue, value: "104")
        ]
        
        driveFoldersContainer.horizontalBar?.image = ImagePropterties()
        driveFoldersContainer.horizontalBar?.image?.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#OOOOOOFF"),
            Properties(attr: Attributes.width.rawValue, value: "40.0"),
            
        ]
        
        driveFoldersContainer.horizontalBar?.title = TextProperties()
        driveFoldersContainer.horizontalBar?.title?.properties = [
            Properties(attr: Attributes.height.rawValue, value: "20"),
            Properties(attr: Attributes.fontSize.rawValue, value: "12"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-SemiBold"),
            Properties(attr: Attributes.textAlignment.rawValue, value: "center"),
            Properties(attr: Attributes.topPadding.rawValue, value:"8")
        ]
        
        driveFoldersContainer.horizontalBar?.properties  = [
            Properties(attr: Attributes.width.rawValue, value: "104"),
            Properties(attr: Attributes.height.rawValue, value: "104")
        ]
        
        
        
        driveFoldersContainer.properties = [
           
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.leftMargin.rawValue, value: "24"),
           
        ]
        return driveFoldersContainer
    }
    
    
    static func getSubTemplateFiles()->FilesContainer{
        var filesContainer = FilesContainer(order: 4)
        filesContainer.tag = 50
        filesContainer.title = TextProperties(tag: 51, text: "Files")
       
        filesContainer.title?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#000000FF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.bottomPadding.rawValue, value: "5.0")
         
        ]
        
        filesContainer.viewAll = TextProperties()
        filesContainer.viewAll?.tag = 52
        filesContainer.viewAll?.properties = [
            Properties(attr: Attributes.textColor.rawValue, value: "#000000FF"),
            
            Properties(attr: Attributes.fontSize.rawValue, value: "16.0"),
            Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Bold"),
            Properties(attr: Attributes.topPadding.rawValue, value: "15.0"),
            Properties(attr: Attributes.bottomPadding.rawValue, value: "5.0")
         
        ]
        
        filesContainer.table = TableViewProperties()
        filesContainer.table?.title = TextProperties()
        filesContainer.table?.image  = ImagePropterties()
        filesContainer.table?.subtitle = TextProperties()
        
        filesContainer.table?.tag = 53
        
        filesContainer.table?.title = TextProperties()
        filesContainer.table?.subtitle = TextProperties()
        filesContainer.table?.image = ImagePropterties()
        
        
        
       
        
        filesContainer.properties = [
            Properties(attr: Attributes.backgroundColor.rawValue, value: "#FFFFFFFF"),
            Properties(attr: Attributes.leftMargin.rawValue, value:"24")
        ]
        return filesContainer
    }
}
