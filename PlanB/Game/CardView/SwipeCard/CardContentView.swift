
import UIKit

class CardContentView: UIView {

  private let backgroundView: UIView = {
    let background = UIView()
    background.clipsToBounds = true
    background.layer.cornerRadius = 15
    background.layer.backgroundColor = 0x2F2F2F.toColor().cgColor
    return background
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  init(withImage image: UIImage?) {
    super.init(frame: .zero)
    imageView.image = image
    initialize()
  }

  required init?(coder aDecoder: NSCoder) {
    return nil
  }

  private func initialize() {
    addSubview(backgroundView)
    backgroundView.anchorToSuperview()
    backgroundView.addSubview(imageView)
    imageView.addConstraint(NSLayoutConstraint(item: imageView,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: imageView,
                                                        attribute: .width,
                                                        multiplier: 3 / 4,
                                                        constant: 0))
    imageView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: nil, right: backgroundView.rightAnchor, paddingTop: 20)
  }
}
