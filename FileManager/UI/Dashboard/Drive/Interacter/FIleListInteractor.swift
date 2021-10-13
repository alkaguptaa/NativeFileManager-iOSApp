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
        let pdfImageUrl = [
            "https://play-lh.googleusercontent.com/nufRXPpDI9XP8mPdAvOoJULuBIH_OK4YbZZVu8i_-eDPulZpgb-Xp-EmI8Z53AlXHpqX",
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/PDF_file_icon.svg/1200px-PDF_file_icon.svg.png",
            "https://is5-ssl.mzstatic.com/image/thumb/Purple125/v4/f2/e5/dd/f2e5dd98-d4b3-ac5a-0e2e-b5c306228ce4/AppIcon-0-1x_U007emarketing-0-7-0-85-220.png/1200x630wa.png",
            "https://images-na.ssl-images-amazon.com/images/I/51Warh2mBVL.png",
           "https://www.google.com/url?sa=i&url=https%3A%2F%2Ftechterms.com%2Fdefinition%2Fpdf&psig=AOvVaw3m1QMAJnJ4UaBW9p_amMvg&ust=1634212067948000&source=images&cd=vfe&ved=0CAgQjRxqFwoTCMi2z8Cox_MCFQAAAAAdAAAAABAf"]
        let imageUrl = [
            "https://1.bp.blogspot.com/-_ZPsKtUEqYs/XXa8PyOOFLI/AAAAAAAAIRs/LFlXjXbxp9EAy0erTBSyo-GNRjqr5hXVACLcBGAs/s1600/image%2B%25281%2529.png",
            "https://storage.googleapis.com/gweb-uniblog-publish-prod/images/Google_Docs.max-1100x1100.png",
            "https://1.bp.blogspot.com/-upTxlyI_lio/X33N6COWGYI/AAAAAAAAJSs/bq8WbJb2aPEEqLiVY6A5GK1cfRMkqweKACLcBGAsYHQ/s1800/05_nofade_sml.gif",
            "https://howdoi.daemen.edu/wp-content/uploads/sites/16/2020/04/Screen-Shot-2020-04-14-at-9.09.47-AM-1-1024x589.png"  ,
            "https://www.mojomedialabs.com/hs-fs/hubfs/screen-doc-text.png?width=550&name=screen-doc-text.png"
        ]
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
        
        for n in 1...5 {
            var fileElement = File(order: n)
            
            fileElement.title = TextProperties()
            fileElement.size = TextProperties()
            fileElement.image = ImagePropterties()
            if n%2==0 {
                fileElement.type = FileType.PDF.rawValue
                fileElement.image?.resource = "file.png"
                fileElement.image?.url = pdfImageUrl[n-1]
            }else{
                fileElement.type = FileType.Image.rawValue
                fileElement.image?.url = imageUrl[n-1]
                fileElement.image?.resource = "file.png"
            }
            
            fileElement.title?.text = "Document \(n)"
            fileElement.size?.text = "192 MB"
            fileList.append(fileElement)
          
        }
        
        
        return fileList
    }
}
