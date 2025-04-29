//
//  HomeCoordinator.swift
//  Weather
//
//  Created by Kayo on 2025-03-27.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    
}

class HomeCoordinator: RootViewCoordinator {
    
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let viewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.delegate = self
        let navigationController = UINavigationController(rootViewController: homeVC)
        return navigationController
    }()
    
    func start() {}
    
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func showDetailViewController(with place: PlaceDetail, photoUrl: String) {
        let detailVC = DetailViewController(with: place, photoUrl: photoUrl)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}
