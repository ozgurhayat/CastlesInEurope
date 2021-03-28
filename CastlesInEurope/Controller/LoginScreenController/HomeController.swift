//
//  HomeController.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 30/11/2020.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    // MARK: - Properties
        
    private var user: User? {
        didSet {
            presentOnboardingIfNeccessary()
            showWelcomeLabel()
        }
    }
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "Welcome User"
        label.alpha = 0
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
        configureUI()
        navigateToMainScreen()
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {_ in self.logout()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - API
    
    func fetchUser() {
        Service.fetchUser { user in
            self.user = user
        }
    }
    
    func fetchUserWithFirestore() {
        Service.fetchUserWithFirestore { user in
            self.user = user
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.presentLoginController()
        } catch {
            print("DEBUG: Error signing out")
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                self.presentOnboardingIfNeccessary()
                self.presentLoginController()
            }
        } else {
//            fetchUser()
            fetchUserWithFirestore()
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientBackground()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Castles in Europe"
        
        let image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerX(inView: view)
        welcomeLabel.centerY(inView: view)
    }
    
    fileprivate func showWelcomeLabel() {
        guard let user = user else { return }
        guard user.hasSeenOnboarding else { return }
        welcomeLabel.text = "Welcome \(user.fullname)"
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
            self.showLoader(true)
        })
        UIView.animate(withDuration: 1) {
            self.welcomeLabel.alpha = 1
        }
    }
    
    fileprivate func presentLoginController() {
        let controller = LoginContoller()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    fileprivate func presentOnboardingIfNeccessary() {
        guard let user = user else { return }
        guard !user.hasSeenOnboarding else { return }
        
        let controller = OnboardingController()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    fileprivate func navigateToMainScreen() {
        // 5 olarak degisecek
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.0, execute: {
            self.showLoader(false)
            let tabBarController = TabBarController()
            self.navigationController?.pushViewController(tabBarController, animated: true)
        })
    }
}

// MARK: - OnboardingControllerDelegate

extension HomeController: OnboardingControllerDelegate {
    func controllerWantsToDismiss(_ controller: OnboardingController) {
        controller.dismiss(animated: true, completion: nil)
//        Service.updateUserHasSeenOnboarding { (error, ref) in
//            self.user?.hasSeenOnboarding = true
//        }
        Service.updateUserHasSeenOnboardingFirestore { error in
            self.user?.hasSeenOnboarding = true
        }
    }
}

extension HomeController: AuthenticationDelegate{
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
//        fetchUser()
        fetchUserWithFirestore()
    }
}
