//
//  PSButton.swift
//  mad-fixed-exercise
//
//  Created by philipp on 17.09.20.
//  Copyright © 2020 philipp. All rights reserved.
//

import UIKit

class PSButton: UIButton {
    
    public var color: UIColor?
    public var pressedColor: UIColor?
    
    override var isHighlighted: Bool {
        didSet(oldValue) {
            if (oldValue) {
                guard let _color = self.color else {
                    return
                }
                self.backgroundColor = _color
            } else {
                guard let _pressedColor = self.pressedColor else {
                    return
                }
                self.backgroundColor = _pressedColor
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
        self.color = UIColor.systemBlue
        self.pressedColor = UIColor.blue
        
        self.layer.backgroundColor = self.color?.cgColor
        self.layer.cornerRadius = 5.0
    }
    
    public convenience init(color: UIColor, pressedColor: UIColor) {
        self.init(frame: CGRect.zero)
        self.color = color
        self.pressedColor = pressedColor
        
        self.layer.backgroundColor = self.color?.cgColor
        self.layer.cornerRadius = 5.0
    }
    
    public convenience init(frame: CGRect, color: UIColor, pressedColor: UIColor) {
        self.init(frame: frame)
        self.color = color
        self.pressedColor = pressedColor
        
        self.layer.backgroundColor = self.color?.cgColor
        self.layer.cornerRadius = 5.0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
