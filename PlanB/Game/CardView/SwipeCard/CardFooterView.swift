
import UIKit

class CardFooterView: UIView {
    
    private var label = UILabel()
    
    init(subtitle: String?) {
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 10
        clipsToBounds = true
        isOpaque = false
        initialize(subtitle: subtitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initialize(subtitle: String?) {
        let attributedText = NSMutableAttributedString()
        
        if let subtitle = subtitle, !subtitle.isEmpty {
            attributedText.append(NSMutableAttributedString(string: subtitle,
                                                            attributes: NSAttributedString.Key.subtitleAttributes))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle],
                                         range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 0
        }
        
        label.attributedText = attributedText
        addSubview(label)
    }
    
    override func layoutSubviews() {
        let padding: CGFloat = 20
        label.frame = CGRect(x: padding,
                             y: bounds.height / 2, //- label.intrinsicContentSize.height - padding,
                             width: bounds.width - 2 * padding,
                             height: bounds.height / 2)
    }
}

extension NSAttributedString.Key {
    
    static var shadowAttribute: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        return shadow
    }()
    
    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        // swiftlint:disable:next force_unwrapping
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
}
