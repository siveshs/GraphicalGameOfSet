//
//  Card.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 10/15/20.
//

import Foundation

struct Card: Equatable {
    enum Number: Int    {
        case one = 1, two, three
        static var all: [Number] {
            return [.one,.two,.three]
        }
    }
    
    enum Shape: Int {
        case shapeA = 1 , shapeB, shapeC
        static var all: [Shape] {
            return [.shapeA,.shapeB,.shapeC]
        }
    }
    
    enum Shading: Int    {
        case shadingA = 1, shadingB, shadingC
        static var all: [Shading] {
            return [.shadingA,.shadingB,.shadingC]
        }
    }
    enum Color: Int  {
        case colorA = 1, colorB, colorC
        static var all: [Color] {
            return [.colorA,.colorB,.colorC]
        }
    }
    
    let number  : Number
    let shape  	: Shape
    let shading : Shading
    let color   : Color
    
    var identifier: Int {
        return (number.rawValue * 1000 + shape.rawValue * 100 + shading.rawValue * 10 + color.rawValue)
    }
    
    static var possibleMatchedSums: [Int] {
        get {
            var possibleMatchedSums = [Int]()
            for thousandsDigit in [3,6,9] {
            for hundredsDigit in [3,6,9] 	{
            for tensDigit in [3,6,9] 		{
            for onesDigit in [3,6,9] 		{
                possibleMatchedSums += [(1000 * thousandsDigit + 100 * hundredsDigit + 10 * tensDigit + onesDigit)]
            }}}}
            return possibleMatchedSums
        }
        
    }
    
    /// Returns true if card1, card2 and card3 form a set
    static func formsASet(card1: Card, card2: Card, card3: Card) -> Bool {

        let sumOfCardIdentifiers = card1.identifier + card2.identifier + card3.identifier

        if Card.possibleMatchedSums.contains(sumOfCardIdentifiers) {
            return true
        } else {
            return false
        }

    }
}
