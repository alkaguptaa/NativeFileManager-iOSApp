//
//  FileListPresenter.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit


class FileListPresenter: FileListViewToPresenterProtocol {
    var view: FileListPresenterToViewProtocol?
    var interactor: FileListPresenterToInteractorProtocol?
    var router: FileListPresenterToRouterProtocol?
    var presenter: FileListViewToPresenterProtocol?
    
    func loadFileList(file:File?) {
        interactor?.getFileList(file: file)
    }
    
    func showFileDetail(file: File, fromView: UIViewController) {
        if !file.isFolder! {
            router?.pushToFolderDetail(file: file, fromView: fromView)
        }else{
            router?.pushToFileDetail(file: file, fromView: fromView)
        }
        
    }
}

extension FileListPresenter: FileListInteractorToPresenterProtocol {
    func fetchFileList(fileList: [File]) {
        view?.showFiles(files: fileList)
    }
}
