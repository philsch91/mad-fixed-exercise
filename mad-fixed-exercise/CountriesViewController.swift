//
//  CountriesViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 20.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Countries"

        if let user = self.user {
            let firebaseService = FirebaseService()

            firebaseService.getCountries(user: user) { (string, error) in
                if let error = error {
                    print(error)
                }

                if let string = string {
                    print(string)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
