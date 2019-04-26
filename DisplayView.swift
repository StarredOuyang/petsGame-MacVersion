//
//  DisplayView.swift
//  ChenxingOuyangLab 5
//
//  Created by ouyang chenxing on 3/25/17.
//  Copyright © 2017 ouyang chenxing. All rights reserved.
//

import Foundation
import AppKit

/// A view for displaying a quantitative value. Set the `value` property to update the view.
/// To animate changes, call the `animateValue` method.
class DisplayView: NSView {
    
    /// The value to visually display. Valid range is between 0 and 1.
    public var value: CGFloat {
        get {
            return self.modelValue
        }
        set(newValue) {
            self.modelValue = newValue
            self.update(animated: false)
        }
    }
    
    /// The color of the display bar.
    public var color: CGColor = .black {
        didSet { self.valueView.layer?.backgroundColor = color }
    }
    
    private var modelValue: CGFloat = 0
    
    private let valueView = NSView()
    
    private var valueFrame: CGRect {
        var widthFraction = self.modelValue
        if widthFraction < 0 { widthFraction = 0 }
        if widthFraction > 1 { widthFraction = 1 }
        return CGRect(x: 0, y: 0, width: widthFraction * self.bounds.width, height: self.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.valueView.layer?.backgroundColor = color
        self.addSubview(self.valueView)
    }
    
    /// Animates the bar to the specified value. Valid range is between 0 and 1.
    public func animateValue(to newValue: CGFloat) {
        self.modelValue = newValue
        self.update(animated: true)
    }
    
    private func update(animated: Bool) {
        if animated {
            NSAnimationContext.runAnimationGroup({(context) -> Void in context.duration = 0.5; self.valueView.animator().frame = self.valueFrame})
        } else {
            self.valueView.animator().frame = self.valueFrame
        }
    }
    
    
}
