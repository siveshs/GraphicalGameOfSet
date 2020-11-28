//
//  outlinedButton.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 11/28/20.
//

import UIKit

@IBDesignable
class outlinedButton: UIButton {

    @IBInspectable
    var outlineColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable
    var outlineStrokeWidth = CGFloat(3.0)
    
    override func draw(_ rect: CGRect) {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        let buttonOutline = UIBezierPath(roundedRect: bounds.insetBy(dx: 1.0, dy: 1.0 ), cornerRadius: bounds.height/4.0)
        outlineColor.setStroke()
        buttonOutline.lineWidth = outlineStrokeWidth
        buttonOutline.stroke()
    }

}
