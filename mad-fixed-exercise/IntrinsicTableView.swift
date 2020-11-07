//
//  IntrinsicTableView.swift
//  mad-fixed-exercise
//
//  Created by philipp on 07.11.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {

    public var contentHeight: CGFloat?

    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()

        guard let contentHeight = self.contentHeight else {
            return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
        }

        if self.contentSize.height < contentHeight {
            return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
        }

        return CGSize(width: UIView.noIntrinsicMetric, height: contentHeight)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
