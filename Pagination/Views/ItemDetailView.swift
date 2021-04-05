import UIKit

class ItemDetailView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .horizontal
        view.spacing = ViewDimensionConstant.sixteen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension ItemDetailView {
    func setUpView() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(stackView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -ViewDimensionConstant.sixteen),
        ])

        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -ViewDimensionConstant.sixteen),
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func fetchImageTextView(text: String,
                            imageName: String) -> ImageTextView {
        let view = ImageTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configView(text: text,
                        imageName: imageName)
        return view
    }

    func setUpAccessibilityId() {
        titleLabel.accessibilityIdentifier = "kIdTitle"
        descLabel.accessibilityIdentifier = "kIdDescription"
    }
}

extension ItemDetailView {
    func configView(data: DatabaseModel) {
        titleLabel.text = data.name
        descLabel.text = data.desc

        stackView.removeAllSubviews()

        for (index, item) in data.items.enumerated() {
            let view = fetchImageTextView(text: item.value,
                                          imageName: item.iconName)
            view.accessibilityIdentifier = "KIdIconText\(index + 1)"
            stackView.addArrangedSubview(view)
        }
    }
}
