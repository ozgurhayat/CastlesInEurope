//
//  RegistrationController.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 29/11/2020.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = registrationViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "castle2"))
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private let fullnameTextField = CustomTextField(placeHolder: "Fullname")
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.title = "Sign Up"
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let alreadyHaveAccountbutton: UIButton = {
        let button = UIButton(type: .system)
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 15)]
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "Log In.", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
        configureNofiticationObservers()
        updateForm()
        createDismissKeyboardTapGesture()
        keyboardChangeTarget()
    }
    
    // MARK: Selectors
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        
//        showLoader(true)
        
//        Service.registerUserWithFirebase(withEmail: email, password: password, fullname: fullname) { (error, ref) in
//            self.showLoader(false)
//            if let error = error {
//                self.showMessage(withTitle: "Error", message: error.localizedDescription)
//                return
//            }
//            self.delegate?.authenticationComplete()
//        }
        
        Service.registerUserWithFireStore(withEmail: email, password: password, fullname: fullname) { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                return
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc func showLoginController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(_ sender: UITextView) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.fullName = sender.text
        }
        updateForm()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientBackground()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 200, width: 200)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,
                                                   passwordTextField,
                                                   fullnameTextField,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountbutton)
        alreadyHaveAccountbutton.centerX(inView: view)
        alreadyHaveAccountbutton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16)
    }
    
    func configureNofiticationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func keyboardChangeTarget() {
        emailTextField.isSecureTextEntry = false
        emailTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        fullnameTextField.delegate = self
        fullnameTextField.tag = 2
    }
}

extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.isEnabled = viewModel.shouldEnabledButton
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
        emailTextField.isSecureTextEntry = false
        fullnameTextField.isSecureTextEntry = false
    }
}

extension RegistrationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true;
        }
        return false
     }
}
