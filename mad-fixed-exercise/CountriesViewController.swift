//
//  CountriesViewController.swift
//  mad-fixed-exercise
//
//  Created by philipp on 20.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class CountriesViewController: BaseViewController {

    @IBOutlet var mainTableView: UITableView!
    public var firebaseService: FirebaseService?
    public var countries: [Country]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Countries"

        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self

        if let firebaseService = self.firebaseService {
            print("firebaseService.isAuthenticated: \(firebaseService.isAuthenticated)")
            firebaseService.getCountries { (countries, error) in
                if let error = error {
                    print(error)
                    let message = self.mapNetworkingErrorToUserMessage(error)
                    self.showAlert(title: "Info", message: message, actions: nil, completionHandler: nil)
                    return
                }

                guard let countries = countries else {
                    return
                }

                print(countries)
                self.countries = countries
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
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

extension CountriesViewController: UITableViewDelegate {
    //TODO
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countries = self.countries {
            return countries.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let countries = self.countries else {
            return cell
        }
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
}
