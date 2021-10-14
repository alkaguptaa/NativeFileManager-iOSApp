//
//  FIleListInteractor.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit
import RealmSwift

class FileListInteractor: FileListPresenterToInteractorProtocol {
    
    var presenter: FileListInteractorToPresenterProtocol?
    
    func loadFiles(path:String?) {
        let networkManager = NetworkManager()
        networkManager.getFiles(path:"/") { response, error in
            
            do{
                let realm = try! Realm()
                let data = realm.objects(FileObject.self)
                
                 if let result = response {
                     self.presenter!.fetchFileListSuccess(files:data)
                 }else if let err = error{
                     self.presenter!.fetchFileListFailed(error:err)
                 }
            }catch{
                print(error)
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
