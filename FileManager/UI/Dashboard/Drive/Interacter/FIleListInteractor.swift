//
//  FIleListInteractor.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit

class FileListInteractor: FileListPresenterToInteractorProtocol {
    
    var presenter: FileListInteractorToPresenterProtocol?
    
    func loadFiles(path:String?) {
        let networkManager = NetworkManager()
        networkManager.getFiles(path:"/") { response, error in
            if let result = response {
                self.presenter!.fetchFileListSuccess(files:result.data)
            }else if let err = error{
                self.presenter!.fetchFileListFailed(error:err)
            }
            
            
        }
    }
    
//    func getFileList(file:File?) {
//        presenter?.fetchFileList(fileList: getAllFilesForJson())
//    }
//    
//    private func getAllFilesForJson() -> [File] {
//        var fileList = [File]()
//        
//        
//        
//        return fileList
//    }
}
