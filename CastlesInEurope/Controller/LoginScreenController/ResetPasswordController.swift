//
//  ResetPasswordController.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 29/11/2020.
//

import UIKit

protocol ResetPasswordControllerDelegate: class {
    func didSendPasswordLink()
}

class ResetPasswordController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = resetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    var email: String?

    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "castle2"))
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private let resetPasswordButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.title = "Send Reset Link"
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleDissmissal), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNofiticationObservers()
        updateForm()
        loadEmail()
        createDismissKeyboardTapGesture()
    }
    
    // MARK: - Selectors
    
    @objc func handleResetPassword() {
        guard let email = viewModel.email else { return }
        
//        showLoader(true)
        
        Service.resetPassword(forEmail: email) { error in
//            self.showLoader(false)
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                return
            }
            self.delegate?.didSendPasswordLink()
        }
    }
    
    @objc func handleDissmissal() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(_ sender: UITextView) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        updateForm()
    }
    
    func configureUI() {
        configureGradientBackground()
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 200, width: 200)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,
                                                   resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    func loadEmail() {
        guard let email = email else { return }
        viewModel.email = email
        emailTextField.text = email
        updateForm()
    }
    
    func configureNofiticationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension ResetPasswordController: FormViewModel {
    func updateForm() {
        resetPasswordButton.isEnabled = viewModel.shouldEnabledButton
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
        emailTextField.isSecureTextEntry = false
    }
}
