//
//  FileListPresenter.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit
import RealmSwift

class FileListPresenter: FileListViewToPresenterProtocol {
    var view: FileListPresenterToViewProtocol?
    var interactor: FileListPresenterToInteractorProtocol?
    var router: FileListPresenterToRouterProtocol?
    var presenter: FileListViewToPresenterProtocol?
    
    func fetchFileList(path:String?) {
        interactor?.loadFiles(path: path)
    }
    
    
    func showFileDetail(file: FileObject, fromView: UIViewController) {
        if file.isDirectory {
            router?.pushToFolderDetail(file: file, fromView: fromView)
        }else{
            router?.pushToFileDetail(file: file, fromView: fromView)
        }
        
    }
}

extension FileListPresenter: FileListInteractorToPresenterProtocol {
    func fetchFileListFailed(error: String?) {
        view?.onFetchResponseFailure(error:error)
    }
    
    
    func fetchFileListSuccess(files: Results<FileObject>?){
        view?.onFetchResponseSuccess(files: files)
    }
    
   
}
