//
//  FileTableViewCell.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/10/21.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    
    
    var order: Int?
    
    func getView() -> UIView {
        self.contentView
    }
    
    let fileImage = UIImageView()
    let titleLabel = PaddedLabel()
    let storageLabel = PaddedLabel()
    let menu = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let hStack = getHStack(spacing: 15,alignment: .fill, distribution: .fillProportionally)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        let vStack = getVStack(spacing: 3,alignment: .fill, distribution: .fillEqually)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#EBF6FEFF")
        fileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fileImage)
        fileImage.translatesAutoresizingMaskIntoConstraints = false
        hStack.addArrangedSubview(view)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 52 ),
            view.heightAnchor.constraint(equalTo: hStack.heightAnchor),
            fileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
       
        
        
        vStack.addArrangedSubview(titleLabel)
        
        vStack.addArrangedSubview(storageLabel)
        
        
        hStack.addArrangedSubview(vStack)
        
        menu.setImage(UIImage(named: "dotted-menu"), for: .normal)
        hStack.addArrangedSubview(menu)
       contentView.addSubview(hStack)
        NSLayoutConstraint.activate([
            menu.widthAnchor.constraint(equalToConstant: 40),
            
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
