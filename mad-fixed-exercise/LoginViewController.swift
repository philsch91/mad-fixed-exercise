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
    var firebaseService: FirebaseService?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Login"
        self.view.backgroundColor = UIColor.white
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        
        print(email)    //m@m.at
        print(password) //madmad
        
        self.loginActivityIndicatorView.startAnimating()
        self.enableSubviews(false)

        let firebaseService = FirebaseService()
        //self.firebaseService = firebaseService

        firebaseService.login(email: email, password: password, completionHandler: { (user, error) -> Void in
            if let error = error {
                let message = self.mapNetworkingErrorToUserMessage(error)
                self.showLoginAlert(title: "Info", message: message, actions: nil, completionHandler: {
                    self.loginActivityIndicatorView.stopAnimating()
                    self.enableSubviews(true)
                })
            }

            if let user = user {
                print(user)
                firebaseService.user = user
                self.firebaseService = firebaseService
                /*
                self.showLoginAlert(title: "Info", message: "Login successful", actions: nil, completionHandler: {
                    self.loginActivityIndicatorView.stopAnimating()
                    self.enableSubviews(true)
                }) */

                DispatchQueue.main.async {
                    self.loginActivityIndicatorView.stopAnimating()
                    self.enableSubviews(true)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        })
    }

    func showLoginAlert(title: String?, message: String?, actions: [UIAlertAction]?, completionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

            if let actions = actions {
                for action in actions {
                    alertController.addAction(action)
                }
            } else {
                let defaultAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(defaultAlertAction)
            }
            self.present(alertController, animated: true, completion: completionHandler);
        }
    }

    func mapNetworkingErrorToUserMessage(_ error: NetworkingError) -> String {
        switch error {
        case NetworkingError.invalidEmailAddress( _):
            return "Invalid email address"
        case NetworkingError.wrongEmailAddress( _):
            return "Wrong email address"
        case NetworkingError.wrongPassword( _):
            return "Wrong password"
        case NetworkingError.statusCode(let statuscode):
            return "Network status code " + String(statuscode)
        default:
            var msg = error.get()
            if msg == "" {
                msg = "Unknown error"
            }
            return msg
        }
    }

    func enableSubviews(_ enabled: Bool) {
        for subview in self.view.subviews {
            subview.isUserInteractionEnabled = enabled
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier, segueId == "loginSegue", let countriesViewController = segue.destination as? CountriesViewController, let firebaseService = self.firebaseService {
            countriesViewController.firebaseService = firebaseService
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

