//
//  SetCardView.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 10/29/20.
//

import UIKit

@IBDesignable
class SetCardView: UIView {

    @IBInspectable
    var pipNumbers: Int = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var pipShape: Int = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var pipColor: Int = 1 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var pipShading: Int = 1 { didSet { setNeedsDisplay() } }
    
    enum CardSelectionState {
        case isNotSelected
        case isSelected
        case isSelectedAndDoesNotMatch
        case isSelectedAndDoesMatch
    }
    
    var selectionState = CardSelectionState.isNotSelected { didSet { setNeedsDisplay() } }
    
    enum CardOrientation {
        case landscape
        case portrait
    }
    
    var cardOrientation: CardOrientation {
        if bounds.width >= bounds.height {
            return .landscape
        } else {
            return .portrait
        }
    }
    
    var cardBounds: CGRect {
        switch cardOrientation {
        case .landscape:
            if bounds.height < (bounds.width / SizeRatios.cardWidthToHeightRatio) {
                // height-constrained
                return CGRect(center: bounds.center,
                                        width: bounds.height * SizeRatios.cardWidthToHeightRatio,
                                        height: bounds.height)
            } else {
                // width-constrained
                return CGRect(center: bounds.center,
                                        width: bounds.width,
                                        height: bounds.width / SizeRatios.cardWidthToHeightRatio)
            }
        case .portrait:
            if bounds.height < (bounds.width / SizeRatios.cardWidthToHeightRatio.inverse) {
                // height-constrained
                return CGRect(center: bounds.center,
                                    width: bounds.height * SizeRatios.cardWidthToHeightRatio.inverse,
                                        height: bounds.height)
            } else {
                // width-constrained
                return CGRect(center: bounds.center,
                                        width: bounds.width,
                                        height: bounds.width / SizeRatios.cardWidthToHeightRatio.inverse)
            }
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        isOpaque = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        let cardOutline = UIBezierPath(roundedRect: cardBounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        
        switch selectionState {
        case .isNotSelected:
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setStroke()
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        case .isSelected:
            #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).setStroke()
            #colorLiteral(red: 0.95, green: 0.9797512364, blue: 1, alpha: 1).setFill()
        case .isSelectedAndDoesNotMatch:
            #colorLiteral(red: 0.7647058964, green: 0.2666666806, blue: 0.2666666806, alpha: 1).setStroke()
            #colorLiteral(red: 0.9816097919, green: 0.9325293023, blue: 0.9333473105, alpha: 1).setFill()
        case .isSelectedAndDoesMatch:
            #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).setStroke()
            #colorLiteral(red: 0.970078739, green: 1, blue: 0.95, alpha: 1).setFill()
        }
        
        cardOutline.fill()
        cardOutline.addClip()
        
        cardOutline.lineWidth = 5.0
        cardOutline.stroke()
        
        
        
        var shapeToDraw: String
        switch pipShape {
        case 1:
            shapeToDraw = "diamond"
        case 2:
            shapeToDraw = "oval"
        case 3:
            shapeToDraw = "squiggle"
        default:
            shapeToDraw = "unknown shape"
        }
        
        var path = UIBezierPath()
        
        var pipSize = CGSize()
        switch cardOrientation {
        case .landscape:
            pipSize = CGSize(width: cardBounds.height*0.70*0.40,
                                   height: cardBounds.height*0.70)
        case .portrait:
            pipSize = CGSize(width: cardBounds.width*0.70,
                                   height: cardBounds.width*0.70*0.40)
        }
        
        switch pipNumbers {
        case 1:
            let pipBounds = CGRect(center: CGPoint(x: cardBounds.midX, y: cardBounds.midY),
                                     size: pipSize)
            path = UIBezierPath.inscribed(shapeToDraw, inFrame: pipBounds)!
            
        case 2:
            switch cardOrientation {
            case .landscape:
                let pipbounds1 = CGRect(center: CGPoint(x: cardBounds.origin.x + cardBounds.width * 1.1 / 3.0,
                                                        y: cardBounds.midY),
                                        size: pipSize)
                path = UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds1)!
                
                let pipbounds2 = CGRect(center: CGPoint(x: cardBounds.origin.x + cardBounds.width * 1.9 / 3.0,
                                                        y: cardBounds.midY),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds2)!)
                
            case .portrait:
                let pipbounds1 = CGRect(center: CGPoint(x: cardBounds.midX,
                                                        y: cardBounds.origin.y + cardBounds.height * 1.1 / 3.0),
                                        size: pipSize)
                path = UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds1)!
                
                let pipbounds2 = CGRect(center: CGPoint(x: cardBounds.midX,
                                                        y: cardBounds.origin.y + cardBounds.height * 1.9 / 3.0),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds2)!)
            }

        case 3:
            switch cardOrientation {
            case .landscape:
                let pipbounds1 = CGRect(center: CGPoint(x: cardBounds.origin.x + cardBounds.width * 1.0 / 4.0,
                                                        y: cardBounds.midY),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds1)!)
                let pipbounds2 = CGRect(center: CGPoint(x: cardBounds.origin.x + cardBounds.width * 2.0 / 4.0,
                                                        y: cardBounds.midY),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds2)!)
                let pipbounds3 = CGRect(center: CGPoint(x: cardBounds.origin.x + cardBounds.width * 3.0 / 4.0,
                                                        y: cardBounds.midY),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds3)!)
                
            case .portrait:
                let pipbounds1 = CGRect(center: CGPoint(x: cardBounds.midX,
                                                        y: cardBounds.origin.y + cardBounds.height * 1.0 / 4.0),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds1)!)
                let pipbounds2 = CGRect(center: CGPoint(x: cardBounds.midX,
                                                        y: cardBounds.origin.y + cardBounds.height * 2.0 / 4.0),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds2)!)
                let pipbounds3 = CGRect(center: CGPoint(x: cardBounds.midX,
                                                        y: cardBounds.origin.y + cardBounds.height * 3.0 / 4.0),
                                        size: pipSize)
                path.append(UIBezierPath.inscribed(shapeToDraw, inFrame: pipbounds3)!)
            }
        default:
            break
        }
        
        switch pipColor {
        case 1:
            #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).setStroke()
            #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).setFill()
        case 2:
            #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).setStroke()
            #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).setFill()
        case 3:
            #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).setStroke()
            #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).setFill()
        default:
            break
        }
        
        switch pipShading {
        case 1: // nofill
            path.lineWidth = 2.0
            path.stroke()
        case 2: // filled
            path.lineWidth = 2.0
            path.stroke()
            path.fill()
        case 3: // shaded
            path.stroke()
            path.addClip()
            let shadedLines = UIBezierPath()
            shadedLines.lineWidth = 1.0
            switch cardOrientation {
            case .landscape:
                for yValue in stride(from: cardBounds.minY, to: cardBounds.maxY, by: 4.0) {
                    shadedLines.move(to: CGPoint(x: cardBounds.minX, y: yValue))
                    shadedLines.addLine(to: CGPoint(x: cardBounds.maxX, y: yValue))
                }
            case .portrait:
                for xValue in stride(from: cardBounds.minX, to: cardBounds.maxX, by: 4.0) {
                    shadedLines.move(to: CGPoint(x: xValue, y: cardBounds.minY))
                    shadedLines.addLine(to: CGPoint(x: xValue, y: cardBounds.maxY))
                }
            }

            shadedLines.stroke()
        default:
            break
        }

    }
    
    
    
}

extension SetCardView {
    struct SizeRatios {
        static let cardWidthToHeightRatio: CGFloat = 1.5
        static let cardWidthToCornerRadiusRatio: CGFloat = 10.0
    }
    
    var cornerRadius: CGFloat {
        return self.bounds.width / SizeRatios.cardWidthToCornerRadiusRatio
    }
}

extension CGRect {
    init(center: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(x: center.x - width/2.0,
                    y: center.y - height/2.0,
                    width: width,
                    height: height)
    }
    
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width/2.0,
                  y: center.y - size.height/2.0,
                  width: size.width,
                  height: size.height)
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self.origin.x = newValue.x - self.width/2.0
            self.origin.y = newValue.y - self.height/2.0
        }
    }
    
    var isPortrait: Bool {
        return (self.height > self.width)
    }
    
    var isSquare: Bool {
        return (self.height == self.width)
    }
    
    var isLandscape: Bool {
        return (self.width > self.height)
    }
}

extension CGPoint {
    /// Returns true when the X and Y coordinates are between 0.0 (inclusive) and 1.0 (inclusive)
    var isNormalized: Bool {
        if self.x >= 0.0, self.x <= 1.0, self.y >= 0.0, self.y <= 1.0 {
            return true
        } else {
            return false
        }
    }
}

extension CGFloat {
    var inverse: CGFloat {
        return 1.0 / self
    }
}

extension UIBezierPath {
    static func ovalInscribedIn(frame: CGRect) -> UIBezierPath {
            return UIBezierPath(roundedRect: frame, cornerRadius: frame.width/2*0.95)
    }
    
    static func diamondInscribedIn(frame: CGRect) -> UIBezierPath {
        let inscribedDiamond = UIBezierPath()
        inscribedDiamond.move(to: CGPoint(x: frame.minX, y: frame.midY))
        inscribedDiamond.addLine(to: CGPoint(x: frame.midX, y: frame.minY))
        inscribedDiamond.addLine(to: CGPoint(x: frame.maxX, y: frame.midY))
        inscribedDiamond.addLine(to: CGPoint(x: frame.midX, y: frame.maxY))
        inscribedDiamond.close()
        return inscribedDiamond
    }
    
    static func squiggleInscribedIn(frame: CGRect) -> UIBezierPath {
        
        /// Will return actual coordinates within the given frame given a normalized point i.e. x and y coordinates vary from 0 to 1.
        /// Will flip x and y coordinates when frame is landscape vs portrait
        func actualCoordinatesOf(normalizedPoint: CGPoint) -> CGPoint? {
            if !normalizedPoint.isNormalized {
                return nil
            } else if frame.isPortrait{
                var actualPoint = CGPoint()
                actualPoint.x = frame.minX + normalizedPoint.x * frame.width
                actualPoint.y = frame.minY + normalizedPoint.y * frame.height
                return actualPoint
            } else {
                var actualPoint = CGPoint()
                actualPoint.x = frame.minX + normalizedPoint.y * frame.width
                actualPoint.y = frame.minY + normalizedPoint.x * frame.height
                return actualPoint
            }
        }
        
        let inscribedSquiggle = UIBezierPath()
        
        struct curvePoint {
            var toPoint: CGPoint
            var controlPointCW: CGPoint
            var controlPointCCW: CGPoint
            
            init() {
                self.toPoint = CGPoint(x: 0.0, y: 0.0)
                self.controlPointCW = CGPoint(x: 0.0, y: 0.0)
                self.controlPointCCW = CGPoint(x: 0.0, y: 0.0)
            }
            
            init(toPoint: CGPoint, controlPointCW: CGPoint, controlPointCCW:CGPoint) {
                self.toPoint = toPoint
                self.controlPointCW = controlPointCW
                self.controlPointCCW = controlPointCCW
            }
        }
        
        let normalizedToPointsAndControlPoints: [curvePoint] = [
            curvePoint(toPoint: CGPoint(x: 0.00, y: 0.10), controlPointCW: CGPoint(x: 0.00, y: 0.15), controlPointCCW: CGPoint(x: 0.00, y: 0.05)),
            curvePoint(toPoint: CGPoint(x: 0.32, y: 0.00), controlPointCW: CGPoint(x: 0.12, y: 0.00), controlPointCCW: CGPoint(x: 0.62, y: 0.00)),
            curvePoint(toPoint: CGPoint(x: 1.00, y: 0.32), controlPointCW: CGPoint(x: 1.00, y: 0.22), controlPointCCW: CGPoint(x: 1.00, y: 0.42)),
            curvePoint(toPoint: CGPoint(x: 0.80, y: 0.64), controlPointCW: CGPoint(x: 0.80, y: 0.54), controlPointCCW: CGPoint(x: 0.80, y: 0.74)),
            curvePoint(toPoint: CGPoint(x: 1.00, y: 0.90), controlPointCW: CGPoint(x: 1.00, y: 0.85), controlPointCCW: CGPoint(x: 1.00, y: 0.95)),
            curvePoint(toPoint: CGPoint(x: 0.68, y: 1.00), controlPointCW: CGPoint(x: 0.88, y: 1.00), controlPointCCW: CGPoint(x: 0.38, y: 1.00)),
            curvePoint(toPoint: CGPoint(x: 0.00, y: 0.68), controlPointCW: CGPoint(x: 0.00, y: 0.78), controlPointCCW: CGPoint(x: 0.00, y: 0.58)),
            curvePoint(toPoint: CGPoint(x: 0.20, y: 0.36), controlPointCW: CGPoint(x: 0.20, y: 0.46), controlPointCCW: CGPoint(x: 0.20, y: 0.26)),
            curvePoint(toPoint: CGPoint(x: 0.00, y: 0.10), controlPointCW: CGPoint(x: 0.00, y: 0.15), controlPointCCW: CGPoint(x: 0.00, y: 0.05)),
        ]
        
        var toPointsAndControlPoints = [curvePoint]()
        
        for normalizedPoint in normalizedToPointsAndControlPoints {
            var currentPoint = curvePoint()
            currentPoint.toPoint = actualCoordinatesOf(normalizedPoint: normalizedPoint.toPoint)!
            currentPoint.controlPointCW = actualCoordinatesOf(normalizedPoint: normalizedPoint.controlPointCW)!
            currentPoint.controlPointCCW = actualCoordinatesOf(normalizedPoint: normalizedPoint.controlPointCCW)!
            toPointsAndControlPoints.append(currentPoint)
        }
        
        inscribedSquiggle.move(to: toPointsAndControlPoints[0].toPoint)
        for index in 1..<toPointsAndControlPoints.count {
            let previousCurvePoint = toPointsAndControlPoints[index - 1]
            let currentCurvePoint = toPointsAndControlPoints[index]
            inscribedSquiggle.addCurve(to: currentCurvePoint.toPoint,
                                       controlPoint1: previousCurvePoint.controlPointCCW,
                                       controlPoint2: currentCurvePoint.controlPointCW)
        }
    
        return inscribedSquiggle
    
}
    
    static func inscribed(_ shape: String, inFrame frame : CGRect) -> UIBezierPath? {
        switch shape {
        case "diamond":
            return diamondInscribedIn(frame: frame)
        case "oval":
            return ovalInscribedIn(frame: frame)
        case "squiggle":
            return squiggleInscribedIn(frame: frame)
        default:
            return nil
        }
    }
}

