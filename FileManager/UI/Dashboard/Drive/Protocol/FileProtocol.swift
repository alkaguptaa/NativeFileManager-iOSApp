//
//  FileProtocol.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit
import RealmSwift

protocol FileListViewToPresenterProtocol: class {
    var view: FileListPresenterToViewProtocol? {get set}
    var interactor: FileListPresenterToInteractorProtocol? {get set}
    var router: FileListPresenterToRouterProtocol? {get set}
    
    func fetchFileList(path:String?)
    
    func showFileDetail(file: FileObject, fromView: UIViewController)
}

protocol FileListPresenterToViewProtocol: class {
    func onFetchResponseSuccess(files:Results<FileObject>?)
    func onFetchResponseFailure(error:String?)
}

protocol FileListPresenterToInteractorProtocol: class {
    var presenter: FileListInteractorToPresenterProtocol? {get set}
    
    func loadFiles(path:String?)
   
}

protocol FileListInteractorToPresenterProtocol: class {
    func fetchFileListSuccess(files:Results<FileObject>?)
    func fetchFileListFailed(error:String?)
    
}

protocol FileListPresenterToRouterProtocol: class {
    static func createFileListModule(fileListRef: FileListView)
    func pushToFileDetail(file: FileObject,fromView: UIViewController)
    func pushToFolderDetail(file: FileObject,fromView: UIViewController)
}
