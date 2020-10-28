//
//  ActivityIndicatorTableHeaderView.swift
//  mad-fixed-exercise
//
//  Created by philipp on 28.10.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class ActivityIndicatorTableHeaderView: UIView {

    public let activityIndicatorView: UIActivityIndicatorView

    override init(frame: CGRect) {
        self.activityIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)
        super.init(frame: frame)

        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.activityIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.activityIndicatorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
