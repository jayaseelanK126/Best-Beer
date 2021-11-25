//
//  Extensions.swift


import UIKit

extension UIImageView
{
    func makeRounded(cornerRadius: CGFloat)
    {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func loadURLImage(urlStr: String)
    {
        if let url = URL(string: urlStr)
        {
            var data = Data()
            do
            {
                data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            }
            catch
            {
                print("\(error)")
            }
        }
    }
}


//MARK: - UIApplication
extension UIApplication
{
    func topMostController() -> UIViewController
    {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let didNoDataReceived = Notification.Name("didNoDataReceived")
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
