//
//  ZView.swift
//  FileManager
//
//  Created by Naveen Chauhan on 15/10/21.
//

import UIKit

import UIKit

enum RelativePosition {
    case top
    case topRight
    case topLeft
    
    case bottom
    case bottomRight
    case bottomLeft
    
    case center
    case centerRight
    case centerLeft
    
    case full
}

public class ZView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addZSubview( view:UIView, position:RelativePosition = .center){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        switch position {
        case .center:
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
        case .centerLeft:
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
        case .centerRight:
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        case .top:
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        case .topLeft:
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
        case .topRight:
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        case .bottomLeft:
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            ])
        case .bottomRight:
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            
        case .full:
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                view.topAnchor.constraint(equalTo: self.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        
        }
    }
    
    
}
