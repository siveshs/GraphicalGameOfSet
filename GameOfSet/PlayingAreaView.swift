//
//  PlayingAreaView.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 11/25/20.
//

import UIKit

/// View that manages a grid of cards;
/// 1. initilaizes the grid
/// 2. Provides behavior so that the grid updates on 'changes'
/// 3. Provides methods for addign, removing and clearing cards
class PlayingAreaView: UIView {
    
    private var landscapeAspectRatio: CGFloat = 1.5
    private lazy var portraitAspectRatio: CGFloat = landscapeAspectRatio.inverse
    
    lazy var grid = Grid(layout: .aspectRatio(1.5), frame: bounds)
    
    override func layoutSubviews() {
        grid.layout = (bounds.isLandscape) ? .aspectRatio(1.5) : .aspectRatio(0.67)
        grid.frame = bounds
        for index in 0..<subviews.count {
            subviews[index].frame = grid[index]!.insetBy(dx: 3.0, dy: 2.0)
        }
        super.layoutSubviews()
    }
    
    private func gridSetup( landscapeAspectRatio: CGFloat , numberOfCells: Int) {
        self.landscapeAspectRatio = landscapeAspectRatio
        self.portraitAspectRatio = landscapeAspectRatio.inverse
        grid.frame = bounds
        grid.layout = (bounds.isLandscape) ? .aspectRatio(1.5) : .aspectRatio(0.67)
        grid.cellCount = numberOfCells
    }
    
    func removeAllCardViews() {
        for index in subviews.indices.reversed() {
            subviews[index].removeFromSuperview()
        }
    }
    
    func addCardView(_ cardViewToBeAdded: SetCardView) {
        cardViewToBeAdded.isOpaque = false
        cardViewToBeAdded.contentMode = .redraw
        addSubview(cardViewToBeAdded)
        setNeedsLayout()
    }
    

}
