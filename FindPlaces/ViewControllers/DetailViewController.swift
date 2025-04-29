//
//  DetailViewController.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-29.
//

import UIKit
import SDWebImage

class DetailViewController: BaseViewController {

    let place: PlaceDetail
    let photoUrl: String
    
    private lazy var placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Place Name"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
       let label = UILabel()
        label.text = "Place Address, City, Country H1H 2V2"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    init(with place: PlaceDetail, photoUrl: String) {
        self.place = place
        self.photoUrl = photoUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        setData()
    }

    func configureLayout() {
        view.addSubview(placeImageView)
        placeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.snp.topMargin).offset(15)
            make.height.equalTo(250)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(placeImageView)
            make.top.equalTo(placeImageView.snp.bottom).offset(10)
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    func setData() {
        placeImageView.sd_setImage(with: URL(string: photoUrl))
        nameLabel.text = place.displayName.text
        addressLabel.text = place.formattedAddress
    }
}
