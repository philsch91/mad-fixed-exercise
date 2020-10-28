//
//  CountryDetailViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 28.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    public var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let country = self.country {
            self.title = country.name
        }
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
