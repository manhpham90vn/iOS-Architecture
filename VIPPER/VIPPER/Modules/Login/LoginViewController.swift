//
//  LoginViewController.swift
//  VIPER
//
//  Created by Manh Pham on 2/8/21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login"
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.didTapLoginButton()
    }
        
}

extension LoginViewController: LoginViewInterface {
        
    func showAlert(title: String, message: String) {
        AppHelper.shared.showAlert(title: title, message: message)
    }
    
}
