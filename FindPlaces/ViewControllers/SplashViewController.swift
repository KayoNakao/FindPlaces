//
//  SplashViewController.swift
//  Weather
//
//  Created by Kayo on 2025-03-27.
//

import UIKit
import Lottie

protocol SplashViewControllerDelegate: AnyObject {
    func showHomeScreen()
}

class SplashViewController: UIViewController {

    weak var delegate: SplashViewControllerDelegate?
    
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = .named("mapSearch")
        view.loopMode = .playOnce
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        configureLayout()
        start()
    }
    
    func configureLayout() {
        view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(40)
            make.center.equalToSuperview()
        }
    }
    
    func start() {
        animationView.play { [weak self] _ in
            self?.delegate?.showHomeScreen()
        }
    }
}
