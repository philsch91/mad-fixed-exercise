//
//  BaseViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 27.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?, completionHandler: (() -> Void)?) {
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

    func enableSubviews(_ enabled: Bool) {
        for subview in self.view.subviews {
            subview.isUserInteractionEnabled = enabled
        }
    }
    /**
     TODO: parameter cases: [Networking: String]
     */
    func mapNetworkingErrorToUserMessage(_ error: NetworkingError) -> String {
        var msg = error.get()
        if msg == "" {
            msg = "Unknown error"
        }
        return msg
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
