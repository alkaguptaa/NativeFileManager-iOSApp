//
//  FIleListInteractor.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit

class FileListInteractor: FileListPresenterToInteractorProtocol {
    var presenter: FileListInteractorToPresenterProtocol?
    
    func getFileList(file:File?) {
        presenter?.fetchFileList(fileList: getAllFilesForJson())
    }
    
    private func getAllFilesForJson() -> [File] {
        var fileList = [File]()
        
        for n in 1...4 {
            var fileElement = File(order: n)
            fileElement.isFolder = true
            fileElement.title = TextProperties()
            fileElement.size = TextProperties()
            fileElement.image = ImagePropterties()
            fileElement.image?.resource = "folder"
            fileElement.title?.text = "Document \(n)"
            fileElement.size?.text = "192 MB"
            fileElement.image?.properties = [
                Properties(attr: Attributes.backgroundColor.rawValue, value: "#CCCCCCFF"),
                Properties(attr: Attributes.width.rawValue, value: "16.8"),
                Properties(attr: Attributes.height.rawValue, value: "19.2"),
            ]
            fileElement.title?.properties = [
                Properties(attr: Attributes.fontSize.rawValue, value: "16"),
                Properties(attr: Attributes.textColor.rawValue, value: "#242833FF"),
                Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular")
            ]
            fileElement.size?.properties = [
                Properties(attr: Attributes.fontSize.rawValue, value: "14"),
                Properties(attr: Attributes.textColor.rawValue, value: "#5D6373FF"),
                Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular")
            ]
            
            fileElement.properties = [
                Properties(attr: Attributes.height.rawValue, value: "42")
            ]
           
            fileList.append(fileElement)
            
            
            
        }
        
        for n in 4...10 {
            var fileElement = File(order: n)
            fileElement.isFolder = false
            fileElement.title = TextProperties()
            fileElement.size = TextProperties()
            fileElement.image = ImagePropterties()
            fileElement.image?.resource = "folder"
            fileElement.title?.text = "Document \(n)"
            fileElement.size?.text = "192 MB"
            fileElement.image?.properties = [
                Properties(attr: Attributes.backgroundColor.rawValue, value: "#CCCCCCFF"),
                Properties(attr: Attributes.width.rawValue, value: "16.8"),
                Properties(attr: Attributes.height.rawValue, value: "19.2"),
            ]
            fileElement.title?.properties = [
                Properties(attr: Attributes.fontSize.rawValue, value: "16"),
                Properties(attr: Attributes.textColor.rawValue, value: "#242833FF"),
                Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular")
            ]
            fileElement.size?.properties = [
                Properties(attr: Attributes.fontSize.rawValue, value: "14"),
                Properties(attr: Attributes.textColor.rawValue, value: "#5D6373FF"),
                Properties(attr: Attributes.fontFamily.rawValue, value: "OpenSans-Regular")
            ]
            
            fileElement.properties = [
                Properties(attr: Attributes.height.rawValue, value: "42")
            ]
           
            fileList.append(fileElement)
            
            
            
        }
        return fileList
    }
}
