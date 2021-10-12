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
    
    func loadFileList(file:File?)
    func showFileDetail(file: File, fromView: UIViewController)
}

protocol FileListPresenterToViewProtocol: class {
    func showFiles(files: [File])
}

protocol FileListPresenterToInteractorProtocol: class {
    var presenter: FileListInteractorToPresenterProtocol? {get set}
    
    func getFileList(file:File?)
}

protocol FileListInteractorToPresenterProtocol: class {
    func fetchFileList(fileList: [File])
}

protocol FileListPresenterToRouterProtocol: class {
    static func createFileListModule(fileListRef: FileListView)
    func pushToFileDetail(file: File,fromView: UIViewController)
    func pushToFolderDetail(file: File,fromView: UIViewController)
}
