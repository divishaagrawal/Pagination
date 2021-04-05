import UIKit

class RepositoryListItemCell: UITableViewCell {
    private var containerStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .center
        view.axis = .horizontal
        view.spacing = ViewDimensionConstant.sixteen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bookmark")
        return imageView
    }()

    private var detailView: ItemDetailView = {
        let view = ItemDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private extension RepositoryListItemCell {
    func setUpView() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(customImageView)
        containerStackView.addArrangedSubview(detailView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            customImageView.heightAnchor.constraint(equalToConstant: ViewDimensionConstant.fifty),
            customImageView.widthAnchor.constraint(equalTo: customImageView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: ViewDimensionConstant.sixteen),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                         constant: -ViewDimensionConstant.sixteen),
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                    constant: ViewDimensionConstant.sixteen),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                       constant: -ViewDimensionConstant.sixteen),
        ])
    }
}

extension RepositoryListItemCell {
    func configCell(data: DatabaseModel) {
        detailView.configView(data: data)
    }
}
