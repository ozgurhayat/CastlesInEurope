//
//  AuthenticationViewModel.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 29/11/2020.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool {get}
    var shouldEnabledButton: Bool {get}
    var buttonTitleColor: UIColor {get}
    var buttonBackgroundColor: UIColor {get}
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var shouldEnabledButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledPurple : disabledPurple
    }
}

struct registrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false
    }
    var shouldEnabledButton: Bool {
        return formIsValid
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    var buttonBackgroundColor: UIColor {
        let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledPurple : disabledPurple
    }
}

struct resetPasswordViewModel: AuthenticationViewModel {
    var email: String?
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
    var shouldEnabledButton: Bool {
        return formIsValid
    }
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    var buttonBackgroundColor: UIColor {
        let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledPurple : disabledPurple
    }
}
