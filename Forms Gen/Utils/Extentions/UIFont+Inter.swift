import UIKit

extension UIFont {
    enum InterWeight {
        case regular
        case medium
        case semiBold
        case bold
        
        var name: String {
            switch self {
            case .regular: return "Inter-Regular"
            case .medium: return "Inter-Medium"
            case .semiBold: return "Inter-SemiBold"
            case .bold: return "Inter-Bold"
            }
        }
    }
    
    static func inter(_ weight: InterWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.name, size: size) ?? .systemFont(ofSize: size)
    }
} 