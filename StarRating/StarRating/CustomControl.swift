//
//  CustomControl.swift
//  StarRating
//
//  Created by Blake Andrew Price on 11/21/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}

class CustomControl: UIControl {
    
    //MARK: - Properties
    var value: Int = 1
    var labels: [UILabel] = []
    
    private var componentDimension: CGFloat = 40.0
    private var componentCount = 5
    private var componentActiveColor = UIColor.black
    private var componentInactiveColor = UIColor.gray
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Functions
    func setup() {
        for n in 1...componentCount {
            let label = UILabel()
            addSubview(label)
            
            label.tag = n
            
            let spacing = componentDimension * CGFloat((n - 1)) + CGFloat(8 * n)
            label.frame = label.frame.offsetBy(dx: spacing, dy: 0.0)
            label.frame.size = CGSize(width: componentDimension, height: componentDimension)
            
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.textAlignment = .center
            label.text = "⭑"
            
            if n == 1 { label.textColor = componentActiveColor }
            else { label.textColor = componentInactiveColor }
            
            labels.append(label)
        }
     }
    
    func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        for index in stride(from: 0, to: labels.count, by: 1) {
            if labels[index].frame.contains(touchPoint) {
                value = labels[index].tag
                for n in stride(from: 0, to: labels.count, by: 1) {
                    if n < value {
                        labels[n].textColor = componentActiveColor
                    } else {
                        labels[n].textColor = componentInactiveColor
                    }
                    sendActions(for: [.valueChanged])
                }
            }
        }
    }
    
    //MARK: - Tracking
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside])
             updateValue(at: touch)
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
}
