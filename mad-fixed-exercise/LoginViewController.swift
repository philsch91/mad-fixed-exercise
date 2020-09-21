//
//  ViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 17.09.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginActivityIndicatorView: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
        self.view.backgroundColor = UIColor.white
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonTapped(button: UIButton) {
        self.validateLoginInput()
    }

    func validateLoginInput() {
        guard let email = self.emailTextField.text, self.emailTextField.text != "" else {
            print("invalid email")
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            self.showLoginAlert(title: "Info", message: "Your email address is invalid", actions: [alertAction], completionHandler: nil)
            return
        }
        
        guard let password = self.passwordTextField.text, self.passwordTextField.text != "" else {
            print("invalid password")
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            self.showLoginAlert(title: "Info", message: "Your password is invalid", actions: [alertAction], completionHandler: nil)
            return
        }
        
        print(email)
        print(password)
        
        self.loginActivityIndicatorView.startAnimating()
        self.enableSubviews(false)
        
        login(email: email, password: password, completionHandler: {
            self.loginActivityIndicatorView.stopAnimating()
            self.enableSubviews(true)
        })
    }
    
    func login(email: String, password: String, completionHandler: (() -> Void)?) {
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            var message = "Login unsuccessful"

            if (email == "philipp.schunker@stud.fh-campuswien.ac.at" && password == "1234") {
                message = "Login successful"
            }

            self.showLoginAlert(title: "Info", message: message, actions: [alertAction], completionHandler: completionHandler)
        })
    }
    
    func showLoginAlert(title: String?, message: String?, actions: [UIAlertAction]?, completionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            if let _actions = actions {
                for _action in _actions {
                    alertController.addAction(_action)
                }
            }
            self.present(alertController, animated: true, completion: completionHandler);
        }
    }
    
    func enableSubviews(_ enabled: Bool) {
        for subview in self.view.subviews {
            subview.isUserInteractionEnabled = enabled
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.validateLoginInput()
        }
        
        return false
    }
}

