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
    @IBOutlet var contentStackView: UIStackView!
    @IBOutlet var nativeTitleLabel: UILabel!
    @IBOutlet var nativeLabel: UILabel!
    @IBOutlet var capitalTitleLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var continentTitleLabel: UILabel!
    @IBOutlet var continentLabel: UILabel!
    @IBOutlet var languagesTitleLabel: UILabel!
    @IBOutlet var languagesTableView: IntrinsicTableView!

    lazy var currencyTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    lazy var currencyLabel = UILabel()

    lazy var phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    lazy var phoneLabel = UILabel()

    public var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")

        if let country = self.country {
            self.title = country.name
            self.nativeLabel.text = country.native
            self.capitalLabel.text = country.capital
            self.continentLabel.text = country.continent

            self.currencyLabel.text = country.currency
            self.phoneLabel.text = country.phone

            // test languageTableView
            if country.name == "Austria" {
                for i in 0...10 {
                    self.country?.languages.append("Language \(i)")
                }
            }
        }

        self.setupUI()
        self.languagesTableView.delegate = self
        self.languagesTableView.dataSource = self
        //self.languagesTableView.reloadData()
    }

    func setupUI() {
        // native
        self.nativeTitleLabel.text = "Native"
        self.nativeTitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        // capital
        self.capitalTitleLabel.text = "Capital"
        self.capitalTitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        // continent
        self.continentTitleLabel.text = "Continent"
        self.continentTitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        // languages
        self.languagesTitleLabel.text = "Languages"
        self.languagesTitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        // currency
        self.currencyTitleLabel.text = "Currency"
        self.contentStackView.addArrangedSubview(self.currencyTitleLabel)
        self.contentStackView.addArrangedSubview(self.currencyLabel)
        // phone
        self.phoneTitleLabel.text = "Phone"
        self.contentStackView.addArrangedSubview(self.phoneTitleLabel)
        self.contentStackView.addArrangedSubview(self.phoneLabel)

        self.languagesTableView.contentHeight = 132
        //self.languagesTableView.separatorInset = UIEdgeInsets.zero
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

extension CountryDetailViewController: UITableViewDelegate {
    //
}

extension CountryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let country = self.country else {
            return 0
        }
        print("country.languages.count \(country.languages.count)")
        return country.languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView(tableView:cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryLanguageTableViewCell", for: indexPath)
        guard let country = self.country else {
            return cell
        }
        cell.textLabel?.text = country.languages[indexPath.row]
        return cell
    }
}
