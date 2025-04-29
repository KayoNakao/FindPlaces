//
//  ViewController.swift
//  CoordinatorTemplate
//
//  Created by Kayo on 2025-03-27.
//

import UIKit
import SnapKit

protocol HomeViewControllerDelegate: AnyObject {
    func showDetailViewController(with place: PlaceDetail, photoUrl: String)
}

class HomeViewController: BaseViewController {

    private var viewModel: HomeViewModel
    weak var delegate: HomeViewControllerDelegate?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        viewModel.onPlacesUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateKeywordButton(for: self?.viewModel.currentKeyword.rawValue ?? 0)
                self?.placeTableView.reloadData()
            }
        }
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
    
    func updateKeywordButton(for tag: Int) {
        keyWordButtonStackView.arrangedSubviews.forEach { button in
            guard let keywordButton = button as? UIButton else { return }
            keywordButton.isSelected = button.tag == tag
        }
    }
    
    @objc func didTapKeyword(_ sender: UIButton) {
        updateKeywordButton(for: sender.tag)
        guard let keyword = Keyword(rawValue: sender.tag) else { return }
        updatePlaces(keyword: keyword)
        viewModel.currentKeyword = keyword
    }
    
    func updatePlaces(keyword: Keyword) {
        Task {
            do {
                try await viewModel.getPlaces(for: keyword)
                placeTableView.reloadData()
            } catch {
                presentErrorAlert(title: Constants.errorTitle, message: Constants.errorMessage)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        let place = viewModel.places[indexPath.row]
        let photoMedia = viewModel.photoMedias[place.id]
        cell.configure(place: place, urlString: photoMedia?.photoUri)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = viewModel.places[indexPath.row]
        let photoMedia = viewModel.photoMedias[place.id]
        delegate?.showDetailViewController(with: place, photoUrl: photoMedia?.photoUri ?? "")
    }
}
