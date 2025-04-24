//
//  ViewController.swift
//  CoordinatorTemplate
//
//  Created by Kayo on 2025-03-27.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {

    private lazy var keywordScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var keyWordButtonStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private lazy var leaddingSpacer: UIView = {
        let view = UIView()
        view.frame.size.width = 20
        return view
    }()

    private lazy var trailingSpacer: UIView = {
        let view = UIView()
        view.frame.size.width = 20
        return view
    }()

    private lazy var placeTableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    func configureLayout() {
        view.addSubview(keywordScrollView)
        keywordScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.height.equalTo(44)
        }
        
        keywordScrollView.addSubview(keyWordButtonStackView)
        keyWordButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        keyWordButtonStackView.addArrangedSubview(leaddingSpacer)
        Keyword.allCases.forEach { keyword in
            let button = KeywordButton()
            button.setTitle(keyword.title, for: .normal)
            button.tag = keyword.rawValue
            button.addTarget(self, action: #selector(didTapKeyword(_:)), for: .touchUpInside)
            keyWordButtonStackView.addArrangedSubview(button)
        }
        keyWordButtonStackView.addArrangedSubview(trailingSpacer)

        view.addSubview(placeTableView)
        placeTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(keywordScrollView.snp.bottom)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    @objc func didTapKeyword(_ sender: UIButton) {
        keyWordButtonStackView.arrangedSubviews.forEach { button in
            guard let keywordButton = button as? UIButton else { return }
            keywordButton.isSelected = button.tag == sender.tag
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
