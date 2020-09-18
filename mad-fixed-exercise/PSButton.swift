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

        self.color = UIColor.systemBlue
        self.pressedColor = UIColor.blue
        self.configure()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)

        self.color = UIColor.systemBlue
        self.pressedColor = UIColor.blue
        self.configure()
    }
    
    public convenience init(color: UIColor, pressedColor: UIColor) {
        self.init(frame: CGRect.zero)

        self.color = color
        self.pressedColor = pressedColor
        self.configure()
    }
    
    public convenience init(frame: CGRect, color: UIColor, pressedColor: UIColor) {
        self.init(frame: frame)

        self.color = color
        self.pressedColor = pressedColor
        self.configure()
    }

    private func configure() {
        self.layer.backgroundColor = self.color?.cgColor
        self.layer.cornerRadius = 5.0

        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        //self.setTitleColor(UIColor.white, for: UIControl.State.selected)
        //self.setTitleColor(UIColor.white, for: UIControl.State.focused)
        self.setTitleColor(UIColor.white, for: UIControl.State.highlighted)

        if let _pressedColor = self.pressedColor {
            self.setBackgroundColor(color: _pressedColor, forState: UIControl.State.highlighted)
        }
    }

    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //context.setFillColor(self.pressedColor?.cgColor)
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(image, for: forState)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
