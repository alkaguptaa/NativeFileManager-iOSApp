//
//  Extension.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
        
}

extension UIStackView {
    func addStackColors(colors: [UIColor],bounds:CGRect ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        for (index, color) in colors.enumerated() {
            // append same color twice
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index)))
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index + 1)))
        }

        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray

        self.backgroundColor = .clear
        self.layer.addSublayer(gradientLayer)

        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.addSublayer(gradientLayer)
        //subView.layer.borderColor = Theme.Color.lightGray.cgColor
        
        insertSubview(subView, at: 0)
        
        // This can be done outside of this funciton
        //self.layer.cornerRadius = self.bounds.height / 2
        //self.layer.masksToBounds = true
    }
    
    func addBackground(color: UIColor,borderWidth:CGFloat = 0.5) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.borderWidth = borderWidth
        //subView.layer.borderColor = Theme.Color.lightGray.cgColor
        if borderWidth > 0 {
          subView.layer.cornerRadius = 10
        }
        
        insertSubview(subView, at: 0)
    }
    
    func addBackgroundImage(color: UIColor) {
        let subView = UIImageView(frame: bounds)
        subView.image = UIImage(named: "background2")
        subView.backgroundColor = color
        subView.alpha = 0.9
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
    func reverseSubviewsZIndex(setNeedsLayout: Bool = true) {
      let stackedViews = self.arrangedSubviews

      stackedViews.forEach {
        self.removeArrangedSubview($0)
        $0.removeFromSuperview()
      }

      stackedViews.reversed().forEach(addSubview(_:))
      stackedViews.forEach(addArrangedSubview(_:))

      if setNeedsLayout {
        stackedViews.forEach { $0.setNeedsLayout() }
      }
    }
   
}


extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        
        return  UIFont(name: "OpenSans-Regular", size: size)!
    }
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
            let newDescriptor = fontDescriptor.addingAttributes([.traits: [
          UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: newDescriptor, size: pointSize)
      }
    
    
}

extension UIView {
    func addColors(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        for (index, color) in colors.enumerated() {
            // append same color twice
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index)))
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index + 1)))
        }

        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray

        self.backgroundColor = .clear
        self.layer.addSublayer(gradientLayer)

        // This can be done outside of this funciton
        //self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
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
}

