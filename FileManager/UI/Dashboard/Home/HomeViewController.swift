//
//  HomeViewController.swift
//  FileManagerApp
//
//  Created by Naveen Chauhan on 05/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
       
//        var template = Template(name: "home")
//        var wrapper =  template.getVStack(spacing: 10, distribution: .fill)
//        wrapper.frame = CGRect(x: 0, y: self.navigationController?.navigationBar.frame.height ?? 100 , width: self.view.frame.width, height: self.view.frame.height-100)
//        
//        var userCard = UserCard(order:1)
//        let textColor = Properties(attr: Attributes.textColor.rawValue, value: "0x000")
//        userCard.title = TextProperties()
//        userCard.title?.properties = [textColor]
//        userCard.title?.text = "Hello User"
//        userCard.properties = [
//            Properties(attr: Attributes.height.rawValue, value: "150")
//        ]
//        
//        userCard.subtitle = TextProperties()
//        userCard.subtitle?.properties = [textColor]
//        userCard.subtitle?.text = "Hi How are you"
//        
//        userCard.image = ImagePropterties()
//        userCard.image?.resource = "user"
//        userCard.image?.properties = [
//                Properties(attr: Attributes.width.rawValue, value: "50"),
//                Properties(attr: Attributes.cornerRadius.rawValue, value: "10"),
//                Properties(attr: Attributes.borderWidth.rawValue, value: "0.5"),
//                Properties(attr:Attributes.contentMode.rawValue, value: "aspectFit"),
//                Properties(attr:Attributes.cornerRadius.rawValue, value: "25"),
//        ]
//        let scrollContainer = ScrollContainer(order: 2)
//
//        let bannerContainer = BannerContainer(order:3)
//        template.banner = bannerContainer
//        template.userCard = userCard
//        template.issuedScroll = scrollContainer
//        wrapper.addArrangedSubview(template.getView())
//        self.view.addSubview(wrapper)
//        
//        NSLayoutConstraint.activate([
//            wrapper.leftAnchor.constraint(equalTo: self.view.leftAnchor),
//            wrapper.rightAnchor.constraint(equalTo: self.view.rightAnchor)
//        ])
//        let jsonData = try! JSONEncoder().encode(template)
//        let jsonString = String(data: jsonData, encoding: .utf8)!
       
        // Do any additional setup after loading the view.
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
