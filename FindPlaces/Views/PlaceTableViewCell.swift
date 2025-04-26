//
//  PlaceTableViewCell.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-24.
//

import UIKit
import SDWebImage

class PlaceTableViewCell: UITableViewCell {

    static let identifier = "PlaceTableViewCell"
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera")
        return imageView
    }()
    
    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Place name"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "15 Sunset street, Sunrise Ave, Mont-Royal, Montreal"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐️ 4.5"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func initViews() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview().inset(10)
        }
        
        container.addSubview(placeImageView)
        placeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
            make.top.bottom.greaterThanOrEqualTo(10)
        }
        
        container.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.width.lessThanOrEqualTo(50)
        }
        
        container.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.top.bottom.greaterThanOrEqualToSuperview().inset(15)
            make.leading.equalTo(placeImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(ratingLabel.snp.leading).offset(-15)
        }
        
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(addressLabel)
    }
    
    func configure(place: PlaceDetail, urlString: String?) {
        nameLabel.text = place.displayName.text
        addressLabel.text = place.formattedAddress
        if let ratings = place.rating {
            ratingLabel.text = "⭐️ " + String(ratings)
        } else {
            ratingLabel.text = " ⭐️ - "
        }
        placeImageView.sd_setImage(with: URL(string: urlString ?? ""))
    }
}
