//
//  FileProtocol.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit

protocol FileListViewToPresenterProtocol: class {
    var view: FileListPresenterToViewProtocol? {get set}
    var interactor: FileListPresenterToInteractorProtocol? {get set}
    var router: FileListPresenterToRouterProtocol? {get set}
    
    func fetchFileList(path:String?)
    
    func showFileDetail(file: File, fromView: UIViewController)
}

protocol FileListPresenterToViewProtocol: class {
    func onFetchResponseSuccess(files:[File]?)
    func onFetchResponseFailure(error:String?)
}

protocol FileListPresenterToInteractorProtocol: class {
    var presenter: FileListInteractorToPresenterProtocol? {get set}
    
    func loadFiles(path:String?)
   
}

protocol FileListInteractorToPresenterProtocol: class {
    func fetchFileListSuccess(files: [File]?)
    func fetchFileListFailed(error:String?)
    
}

protocol FileListPresenterToRouterProtocol: class {
    static func createFileListModule(fileListRef: FileListView)
    func pushToFileDetail(file: File,fromView: UIViewController)
    func pushToFolderDetail(file: File,fromView: UIViewController)
}
