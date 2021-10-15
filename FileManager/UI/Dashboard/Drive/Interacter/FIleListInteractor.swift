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
                /////////////////////////THIS IS THE DUMMY DATA TO DISPLAY//////////////////////////////
                var apiResponse = FileApiResponse(status: "success", data: nil)
                if apiResponse != nil {
                    let jsonString =
                        """
                        {
                        "status":"success",
                        "data":[ {
                                "name":"File 1", "Key_name":"hello", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"Collection"
                            },{
                                "name":"File 2", "Key_name":"hello", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"Collection"
                            },{
                                "name":"File 3", "Key_name":"hello", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"Collection"
                            },{
                                "name":"File 4", "Key_name":"hello", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"Collection"
                            },{
                                "name":"File 5", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"PDF"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            },{
                                "name":"File 6", "Key_name":"hello5", "human_size":"1 MB","lastModified":"10-10-2010","size":"2MB","ext":"IMAGG"
                            }]
                        }
                        """
                    let jsonData = jsonString.data(using: .utf8)!
                    let files = try! JSONDecoder().decode(FileApiResponse.self, from: jsonData)
                    if let entities = files.data{
                        self.saveFilesData(files: entities, callback: { objects in
                            if let values = objects {
                                self.presenter!.fetchFileListSuccess(files:values)
                            }else{
                                self.presenter!.fetchFileListFailed(error:"Database error occured")
                            }
                            
                            
                        })
                      
                        
                    }
                    
                    
                }
                ///////////////////////////////END//////////////////////////////
                if let err = error{
                    self.presenter!.fetchFileListFailed(error:err)
                }
                
                
                
            }catch{
                print(error)
            }
           
             
            
            
            
        }
    }
    
    func saveFilesData(files:[File], callback: (Results<FileObject>?)->Void){
        let realm = try! Realm()
        try! realm.write{
            realm.delete(realm.objects(FileObject.self))
        }
        for file in files {
            let fileObj = FileObject()
            fileObj.name = file.name ?? "Default Name"
            fileObj.ext = file.ext ?? "File"
            fileObj.size = file.size ?? "0 MB"
            try! realm.write{
                realm.add(fileObj)
            }
        }
       // let data = realm.objects(FileObject.self)
        let tasks = realm.objects(FileObject.self)
        // You can freeze collections
        let frozenTasks = tasks.freeze()
        
        callback(frozenTasks)
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
