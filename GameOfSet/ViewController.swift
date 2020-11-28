//
//  ViewController.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 10/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var game = GameOfSet() {
        didSet {
            updateDisplayedCards()
            score.text = "Score: " + String(game.score)
        }
    }
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var newGame: UIButton!  {
        didSet {
            newGame.layer.cornerRadius = 4.0
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = GameOfSet()
    }
    
    @IBOutlet weak var drawCardsButton: UIButton! {
        didSet {
            drawCardsButton.layer.cornerRadius = 4.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add swipe gesture recognizer
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(drawThreeCards(_:)))
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        swipeGestureRecognizer.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        // add rotation gesture recognizer
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(shuffleDisplayedCards(byHandlingRotationRecognizer:)))
        view.addGestureRecognizer(rotationGestureRecognizer)
        
        updateDisplayedCards()
        score.text = "Score: " + String(game.score)
    }
    
    @objc func shuffleDisplayedCards(byHandlingRotationRecognizer recognizer: UIRotationGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            game.shuffleDisplayedCards()
        default: break
        }
    }
    
    @objc func touchCard(_ sender: UITapGestureRecognizer) {
        if let indexOfTouchedCard = playingAreaView.subviews.firstIndex(of: sender.view!) {
            game.pickDisplayedCard(at: indexOfTouchedCard)
        }
        updateDisplayedCards()
        score.text = "Score: " + String(game.score)
    }
    
    @IBAction func drawThreeCards(_ sender: UIButton) {
            game.drawThreeCards()
            updateDisplayedCards()
    }
    
    @IBOutlet weak var playingAreaView: PlayingAreaView!
    
    private func addGestureRecognizersToCardView(_ cardView: SetCardView) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchCard))
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        cardView.addGestureRecognizer(tapRecognizer)
    }
    
    private func updateDisplayedCards() {
        //create a grid with the correct aspect ratio and number of selected cards
        if playingAreaView.bounds.isLandscape {
            playingAreaView.grid = Grid(layout: .aspectRatio(1.5), frame: playingAreaView.bounds)
        } else {
            playingAreaView.grid = Grid(layout: .aspectRatio(0.67), frame: playingAreaView.bounds)
        }
        playingAreaView.grid.cellCount = game.displayedCards.count
        
        //remove all subviews
        playingAreaView.removeAllCardViews()
         
        //for each displayed card in game, add a setCardView to the playingAreaGrid
        for index in 0..<game.displayedCards.count {
            // create a set card with the correct configuration
            let cardViewToBeAdded = SetCardView()
            cardViewToBeAdded.pipShape = game.displayedCards[index].shape.rawValue
            cardViewToBeAdded.pipNumbers = game.displayedCards[index].number.rawValue
            cardViewToBeAdded.pipShading = game.displayedCards[index].shading.rawValue
            cardViewToBeAdded.pipColor = game.displayedCards[index].color.rawValue
            
            // set selection status of card
            
            //add gesture recognizer
            addGestureRecognizersToCardView(cardViewToBeAdded)
            
            // add as subview
            playingAreaView.addCardView(cardViewToBeAdded)
        }
        
        switch game.selectedCardTracker {
        case .zero: break
            
        case .one(let indexOfCard1):
            if let cardView1 = playingAreaView.subviews[indexOfCard1] as? SetCardView {
                cardView1.selectionState = .isSelected
            }
            
        case let .two(indexOfCard1, indexOfCard2):
            if let cardView1 = playingAreaView.subviews[indexOfCard1] as? SetCardView {
                cardView1.selectionState = .isSelected
            }
            if let cardView2 = playingAreaView.subviews[indexOfCard2] as? SetCardView {
                cardView2.selectionState = .isSelected
            }
            
        case let .three(indexOfCard1, indexOfCard2, indexOfCard3):
            if let cardView1 = playingAreaView.subviews[indexOfCard1] as? SetCardView {
                cardView1.selectionState = (game.selectedCardsMatch) ? .isSelectedAndDoesMatch : .isSelectedAndDoesNotMatch
            }
            if let cardView2 = playingAreaView.subviews[indexOfCard2] as? SetCardView {
                cardView2.selectionState = (game.selectedCardsMatch) ? .isSelectedAndDoesMatch : .isSelectedAndDoesNotMatch
            }
            if let cardView3 = playingAreaView.subviews[indexOfCard3] as? SetCardView {
                cardView3.selectionState = (game.selectedCardsMatch) ? .isSelectedAndDoesMatch : .isSelectedAndDoesNotMatch
            }
        }
        
}

}
