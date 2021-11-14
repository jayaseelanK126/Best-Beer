//
//  CSS.swift

import Foundation
import UIKit

class CSS: NSObject
{
    static func customLabel(_ label: UILabel, textColor: UIColor)
    {
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.textColor = textColor
    }
    
    static func customCardView(_ view: UIView?,Bgcolor : UIColor = .white,BorderColor: UIColor = .lightGray, borderWidth: CGFloat = 0.2, cornerRadius: CGFloat = 5.0, isClipsToBounds: Bool = false, isDefaultValues: Bool = true)
    {
        if let view = view
        {
            view.backgroundColor = Bgcolor
            view.layer.cornerRadius = isDefaultValues ? 13.0 : cornerRadius
            view.layer.borderColor = isDefaultValues ? UIColor.clear.cgColor : BorderColor.cgColor
            view.layer.borderWidth = isDefaultValues ? 0.0 : (borderWidth)
            view.layer.shadowColor = BorderColor.cgColor
            view.layer.shadowOpacity = isDefaultValues ? 0.5 : 0.5
            view.layer.shadowRadius = isDefaultValues ? 6.0 : 3.0
            view.layer.shadowOffset = isDefaultValues ? CGSize(width: 0, height: 0) : CGSize(width: 0, height: 2)
            view.clipsToBounds = isClipsToBounds
        }
    }
    
    
    class func inserGradientLayer(layer: CALayer, Colors: [UIColor], isRoundCorner: Bool = false, cornerRadius: CGFloat = 0.0)
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.name = "gradient"
        gradient.colors = Colors.map({$0.cgColor})
        gradient.frame = layer.bounds
        layer.cornerRadius = isRoundCorner ? (layer.bounds.height / 2) : cornerRadius
        layer.insertSublayer(gradient, at: 0)
        layer.masksToBounds = true
        
    }
    
    
    static func customButton(button: UIButton, titleNormalColor: UIColor, titleSelectedColor: UIColor, backgroundColor: UIColor = .white, isBorder: Bool = false, borderColor: UIColor = .white, borderWidth: CGFloat = 0.0, isRoundCorner: Bool = false, cornerRadius: CGFloat = 2.0, isShadow: Bool = false)
    {
        
        if button.layer != nil
        {
            CSS.inserGradientLayer(layer: button.layer, Colors: [#colorLiteral(red: 0.290884316, green: 0.6459454894, blue: 0.9161052108, alpha: 1),#colorLiteral(red: 0.04919955879, green: 0.2176415026, blue: 0.4419623315, alpha: 1)])
        }
        
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = isRoundCorner ? button.frame.size.height / 2 : cornerRadius
        button.setTitleColor(titleNormalColor, for: .normal)
        button.setTitleColor(titleSelectedColor, for: .selected)
        button.tintColor = UIColor.clear
        button.backgroundColor = backgroundColor
        
        if isBorder
        {
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = borderWidth
        }
        else
        {
            button.layer.borderColor = UIColor.clear.cgColor
            button.layer.borderWidth = 0
        }
        
        if isShadow
        {
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            button.layer.shadowOpacity = 0.5
            button.layer.shadowRadius = 1.0
            button.clipsToBounds = false
        }
        else
        {
            button.clipsToBounds = true
        }
    }
}
