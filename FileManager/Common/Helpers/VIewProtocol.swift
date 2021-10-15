//
//  VIewProtocol.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation
import UIKit

protocol ViewProtocol {
    var order: Int?{set get}
    var tag: Int?{set get}
    func getView()->UIView
   
    
    func getVStack(spacing:CGFloat,alignment:UIStackView.Alignment, distribution:UIStackView.Distribution)->UIStackView
    func getHStack(spacing:CGFloat,alignment:UIStackView.Alignment, distribution:UIStackView.Distribution)->UIStackView
    
    
    func setTextProperties(label:PaddedLabel, properties:[Properties])
    func setImageProperties(image:UIImageView, properties:[Properties])
    func setRelativeStackProperties(view:UIView,relativeView:UIView, properties:[Properties])
    func setStackProperties(stack:UIView, properties:[Properties])
    func getLabel()->PaddedLabel
    func getImageView()->UIImageView
}
extension ViewProtocol{
   
    
    
     func getVStack(spacing:CGFloat,alignment:UIStackView.Alignment = .top, distribution:UIStackView.Distribution)->UIStackView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.alignment = alignment
        stack.distribution = distribution
        return stack
    }
    
    func getHStack(spacing:CGFloat,alignment:UIStackView.Alignment = .leading, distribution:UIStackView.Distribution)->UIStackView{
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = alignment
        stack.spacing = spacing
        stack.distribution = distribution
        return stack
    }
    
    
    func setTextProperties(label:PaddedLabel, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.textColor.rawValue:
                label.textColor = UIColor(hex: property.value!)
            case Attributes.backgroundColor.rawValue:
                label.textColor = UIColor(hex: property.value!)
            case Attributes.fontWeight.rawValue:
                switch property.value! {
                case "700":
                    label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .bold)
                    
                case "400":
                    label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .regular)
                default:
                    label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .medium)
                }
                
                
            case Attributes.fontFamily.rawValue:

                if let font =  UIFont(name: property.value!, size: label.font.pointSize) {
                    label.font = font
                }else{
                    label.font = UIFont.appRegularFontWith(size:label.font.pointSize)
                }
            case Attributes.fontSize.rawValue:
                label.font = UIFont.appRegularFontWith(size:CGFloat((property.value! as NSString).floatValue))
            case Attributes.topPadding.rawValue:
                label.paddingTop = CGFloat((property.value! as NSString).floatValue)
            case Attributes.leftPadding.rawValue:
                label.paddingLeft = CGFloat((property.value! as NSString).floatValue)
            case Attributes.rightPadding.rawValue:
                label.paddingRight = CGFloat((property.value! as NSString).floatValue)
            case Attributes.bottomPadding.rawValue:
                label.paddingBottom = CGFloat((property.value! as NSString).floatValue)
            case Attributes.textAlignment.rawValue:
                switch property.value! {
                    case "center":
                        label.textAlignment = .center
                        
                    case "left":
                        label.textAlignment = .left
                    case "right":
                        label.textAlignment = .right
                    default:
                        label.textAlignment = .justified
                }
                
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    label.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
                
               
            default:
                print("NA")
            }
        }
    }
    
    func setButtonProperties(button:UIButton, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.height.rawValue:
                NSLayoutConstraint.activate([
                    button.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.textColor.rawValue:
                button.titleLabel?.textColor = UIColor(hex: property.value!)
            case Attributes.backgroundColor.rawValue:
                button.backgroundColor = UIColor(hex: property.value!)
            case Attributes.fontSize.rawValue:
            button.titleLabel?.font = UIFont.appRegularFontWith(size:CGFloat((property.value! as NSString).floatValue))
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.cornerRadius.rawValue:
                button.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
                button.layer.masksToBounds = true
                
               
            default:
                print("NA")
            }
        }
    }
    
    
    func setImageProperties(image:UIImageView, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    image.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.height.rawValue:
                NSLayoutConstraint.activate([
                    image.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.imageNamed.rawValue:
                image.image = UIImage(named: property.value!)
            case Attributes.contentMode.rawValue:
                switch property.value {
                    case "aspectFit":
                        image.contentMode = .scaleAspectFit
                    default:
                        print("NA")
                }
                
            case Attributes.topMargin.rawValue:
                if let st = image.superview as? UIStackView {
                    st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: CGFloat((property.value! as NSString).floatValue), leading: 0, bottom: 0, trailing: 0)
                    st.isLayoutMarginsRelativeArrangement = true
                }
               
               
            default:
                print("NA")
            }
        }
    }
    
    func setStackProperties(stack:UIView, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    stack.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.height.rawValue:
                NSLayoutConstraint.activate([
                    stack.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.backgroundColor.rawValue:
                stack.backgroundColor = UIColor(hex: property.value!)
            case Attributes.margin.rawValue:
                
                if let st = stack as? UIStackView,let value = property.value as NSString? ,let arr = value.components(separatedBy: ",") as? [NSString]{
                     
                        
                    let leading = CGFloat(arr[0].floatValue)
                        let top = CGFloat(arr[1].floatValue)
                      let trailing = CGFloat(arr[2].floatValue)
                    let bottom = CGFloat(arr[3].floatValue)
                        st.directionalLayoutMargins = NSDirectionalEdgeInsets(top:top , leading: leading, bottom: bottom, trailing: trailing)
                    st.isLayoutMarginsRelativeArrangement = true
                        
                    }
                  
                
            case Attributes.topMargin.rawValue:
                
                if let st = stack as? UIStackView {
                    
                    st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: CGFloat((property.value! as NSString).floatValue), leading: 0, bottom: 0, trailing: 0)
                    st.isLayoutMarginsRelativeArrangement = true
                }
        
            case Attributes.leftMargin.rawValue:
                if let st = stack as? UIStackView {
                    st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CGFloat((property.value! as NSString).floatValue), bottom: 0, trailing: 0)
                    st.isLayoutMarginsRelativeArrangement = true
                    st.translatesAutoresizingMaskIntoConstraints = false
                }
            case Attributes.leftRightMargin.rawValue:
                if let st = stack as? UIStackView {
                    let margin:CGFloat = CGFloat((property.value! as NSString).floatValue)
                    st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin)
                    st.isLayoutMarginsRelativeArrangement = true
                    st.translatesAutoresizingMaskIntoConstraints = false
                }
            default:
                print("NA")
            }
        }
    }
    
    func setRelativeStackProperties(view:UIView,relativeView:UIView, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.relativeWidthRatio.rawValue:
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeHeightRatio.rawValue:
                NSLayoutConstraint.activate([
                    view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeWidth.rawValue:
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeHeight.rawValue:
                NSLayoutConstraint.activate([
                    view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeTopMargin.rawValue:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo:relativeView.topAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeTopMarginRatio.rawValue:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalToSystemSpacingBelow: relativeView.topAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeBottomMargin.rawValue:
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo:relativeView.topAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeRightMargin.rawValue:
                NSLayoutConstraint.activate([
                    view.rightAnchor.constraint(equalTo:relativeView.rightAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.relativeleftMargin.rawValue:
                NSLayoutConstraint.activate([
                    view.leftAnchor.constraint(equalTo:relativeView.leftAnchor, constant: CGFloat((property.value! as NSString).floatValue))
                ])
             
            default:
                print("NA")
            }
        }
    }
    
    func setZStackProperties(view:UIView, properties:[Properties]){
        for property in properties {
            switch property.attr {
            case Attributes.width.rawValue:
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
            case Attributes.height.rawValue:
                NSLayoutConstraint.activate([
                    view.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
                ])
             
            default:
                print("NA")
            }
        }
    }
    
    func getLabel()->PaddedLabel  {
        return PaddedLabel()
    }
    
    func getButton()->PaddedLabel  {
        return PaddedLabel()
    }
    
    
    func getImageView()->UIImageView{
        return UIImageView()
    }
}
