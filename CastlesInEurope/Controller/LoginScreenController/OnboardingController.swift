//
//  OnboardingController.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 01/12/2020.
//

import Foundation
import paper_onboarding

protocol OnboardingControllerDelegate: class {
    func controllerWantsToDismiss(_ controller: OnboardingController)
}

class OnboardingController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: OnboardingControllerDelegate?
    private var onboardingItems = [OnboardingItemInfo]()
    private var onboardingView = PaperOnboarding()
    
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(dismissOnboarding), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureOnboardingDataSource()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func dismissOnboarding() {
        delegate?.controllerWantsToDismiss(self)
    }
    // MARK: - Helpers
    
    func animatedGetStartedButton(_ shouldShow: Bool) {
        let alpha: CGFloat = shouldShow ? 1 : 0
        UIView.animate(withDuration: 0.5) {
            self.getStartedButton.alpha = alpha
    }
    }
    
    func configureUI() {
        view.addSubview(onboardingView)
        onboardingView.fillSuperview()
        onboardingView.delegate = self
        
        view.addSubview(getStartedButton)
        getStartedButton.alpha = 0
        getStartedButton.centerX(inView: view)
        getStartedButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 128)
    }
    
    func configureOnboardingDataSource() {
        let item1 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "a").withRenderingMode(.alwaysOriginal), title: MSG_METRICS, description: MSG_ONBOARDING_METRICS, pageIcon: UIImage(), color: .systemPurple, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
        
        let item2 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "ghost.png").withRenderingMode(.alwaysOriginal), title: MSG_NOTIFICATIONS, description: MSG_ONBOARDING_NOTIFICATIONS, pageIcon: UIImage(), color: .systemBlue, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
        
        let item3 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "c").withRenderingMode(.alwaysOriginal), title: MSG_DASHBOARD, description: MSG_ONBOARDING_DASHBOARD, pageIcon: UIImage(), color: .systemIndigo, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
        
        onboardingItems.append(item1)
        onboardingItems.append(item2)
        onboardingItems.append(item3)
        
        onboardingView.dataSource = self
        onboardingView.reloadInputViews()
    }
}

extension OnboardingController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        return onboardingItems.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return onboardingItems[index]
    }
}

extension OnboardingController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        let viewModel = OnboardingViewModel(itemCount: onboardingItems.count            )
        let shouldShow = viewModel.shouldShowGetStartedButton(forIndex: index)
        animatedGetStartedButton(shouldShow)
        }
    }
