//
//  FileListRouter.swift
//  FileManager
//
//  Created by Naveen Chauhan on 08/10/21.
//

import UIKit
import Foundation

class FileListRouter: FileListPresenterToRouterProtocol {
    static func createFileListModule(fileListRef: FileListView) {
        let presenter: FileListViewToPresenterProtocol & FileListInteractorToPresenterProtocol = FileListPresenter()
        fileListRef.presenter = presenter
        fileListRef.presenter?.router = FileListRouter()
        fileListRef.presenter?.view = fileListRef
        fileListRef.presenter?.interactor = FileListInteractor()
        fileListRef.presenter?.interactor?.presenter = presenter
    }
    
   
    
    
    func pushToFileDetail(file: FileObject, fromView: UIViewController) {
//        let list = FileListView(file:file)
//
//        fromView.navigationController?.pushViewController(list, animated:true)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ColorDetailView") as! FileDetailView
//       FileDetailRouter.createColorDetailModule(colorDetailRef: vc, colorDetail: color)
//        fromView.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToFolderDetail(file: FileObject, fromView: UIViewController) {
//        let list = FileListView(file:file)
//        
//        fromView.navigationController?.pushViewController(list, animated:true)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ColorDetailView") as! FileDetailView
//       FileDetailRouter.createColorDetailModule(colorDetailRef: vc, colorDetail: color)
//        fromView.navigationController?.pushViewController(vc, animated: true)
    }
}
