//
//  DashboardTabBarController.swift
//  FileManagerApp
//
//  Created by Naveen Chauhan on 05/10/21.
//

import UIKit

class DashboardTabBarController: UITabBarController {
   lazy var fileListVC: FileListView = FileListView(file: nil)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fileListVC.title = "Drive"
       
        self.viewControllers = [fileListVC]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        edgesForExtendedLayout = []
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
