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
            fileElement.type = FileType.Directory.rawValue
            fileElement.title = TextProperties()
            fileElement.size = TextProperties()
            fileElement.image = ImagePropterties()
            fileElement.image?.resource = "folder"
            fileElement.title?.text = "Document \(n)"
            fileElement.size?.text = "192 MB"
            
            fileList.append(fileElement)
            
            
            
        }
        
        for n in 4...10 {
            var fileElement = File(order: n)
            
            fileElement.title = TextProperties()
            fileElement.size = TextProperties()
            fileElement.image = ImagePropterties()
            if n%2==0 {
                fileElement.type = FileType.PDF.rawValue
                fileElement.image?.resource = "file"
            }else{
                fileElement.type = FileType.Image.rawValue
                fileElement.image?.resource = "file"
            }
            
            fileElement.title?.text = "Document \(n)"
            fileElement.size?.text = "192 MB"
            fileList.append(fileElement)
          
        }
        
        
        return fileList
    }
}
