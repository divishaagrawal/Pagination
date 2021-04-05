import UIKit

class ImageTextView: UIView {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        setUpAccessibilityId()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension ImageTextView {
    func setUpView() {
        addSubview(imageView)
        addSubview(textLabel)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor,
                                                constant: -ViewDimensionConstant.eight),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ViewDimensionConstant.twenty),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func setUpAccessibilityId() {
        textLabel.accessibilityIdentifier = "kIDIconText"
        imageView.accessibilityIdentifier = "kIdImageView"
    }
}

extension ImageTextView {
    func configView(text: String,
                    imageName: String) {
        textLabel.text = text
        imageView.image = UIImage(named: imageName)
    }
}
