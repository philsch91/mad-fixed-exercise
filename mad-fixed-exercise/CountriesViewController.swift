//
//  CountriesViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 20.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    public var firebaseService: FirebaseService?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Countries"

        if let firebaseService = self.firebaseService {
            print("firebaseService.isAuthenticated: \(firebaseService.isAuthenticated)")
            firebaseService.getCountries { (countries, error) in
                if let error = error {
                    print(error)
                }

                if let countries = countries {
                    print(countries)
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
