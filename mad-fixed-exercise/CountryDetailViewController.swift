//
//  CountryDetailViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 28.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    @IBOutlet var contentView: UIStackView!
    @IBOutlet var nativeLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var continentLabel: UILabel!
    @IBOutlet var languagesTableView: UITableView!

    public var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let country = self.country {
            self.title = country.name
            self.nativeLabel.text = country.native
            self.capitalLabel.text = country.capital
            self.continentLabel.text = country.continent
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
