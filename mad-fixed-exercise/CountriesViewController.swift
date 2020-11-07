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

    //private var mainTableViewHeaderView: ActivityIndicatorTableHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Countries"

        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self

        /*
        let mainTableViewHeaderView = ActivityIndicatorTableHeaderView(frame: CGRect.zero)
        mainTableViewHeaderView.activityIndicatorView.startAnimating()
        self.mainTableView.tableHeaderView = mainTableViewHeaderView
        self.mainTableViewHeaderView = mainTableViewHeaderView */

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        self.mainTableView.refreshControl = refreshControl
        self.mainTableView.refreshControl?.beginRefreshing()

        self.refreshData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if let indexPath = self.mainTableView.indexPathForSelectedRow {
            self.mainTableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.updateHeaderViewHeight(for: self.mainTableView.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else {
            return
        }

        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: self.view.bounds.width - 32, height: 0)).height
    }

    @objc func refreshData() {
        guard let firebaseService = self.firebaseService else {
            return
        }

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
            self.reloadMainTableViewData()
        }
    }

    func reloadMainTableViewData() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
            /*
            if let mainTableViewHeaderView = self.mainTableViewHeaderView, mainTableViewHeaderView.activityIndicatorView.isAnimating {
                mainTableViewHeaderView.activityIndicatorView.stopAnimating()
            } */
            if let refreshControl = self.mainTableView.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let segueId = segue.identifier, segueId == "countryDetailSegue", let countryDetailViewController = segue.destination as? CountryDetailViewController, let country = sender as? Country {
            countryDetailViewController.country = country
        }
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let countries = self.countries else {
            return
        }

        guard indexPath.row < countries.count else {
            return
        }

        let country = countries[indexPath.row]
        //print(country)
        /*
        let detailViewController = CountryDetailViewController()
        detailViewController.country = country
        self.navigationController?.pushViewController(detailViewController, animated: true) */
        self.performSegue(withIdentifier: "countryDetailSegue", sender: country)
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countries = self.countries else {
            return 0
        }

        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath)
        guard let countries = self.countries else {
            return cell
        }
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
}
