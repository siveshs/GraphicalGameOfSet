//
//  GameOfSet.swift
//  GameOfSet
//
//  Created by Sivesh Selvakumar on 10/14/20.
//

import Foundation

struct GameOfSet {
    
    private(set) var threeOrMoreCardsLeft = true
    private var availableCards = [Card]() {
        didSet {
            threeOrMoreCardsLeft = (availableCards.count >= 3) ? true: false
        }
    }
    
    private(set) var displayedCards = [Card]()
    private(set) var hiddenIndicesInDisplayedCards = [Int]()
    private var matchedCards = [Card]()
    
    mutating func shuffleDisplayedCards() {
        displayedCards.shuffle()
    }
    
    private(set) var selectedCardsMatch = false
    
    private(set) var score = 0
    
    enum SelectedCardTracker {
        case zero
        case one(Int)
        case two(Int, Int)
        case three(Int, Int, Int)
    }
    
    private(set) var selectedCardTracker = SelectedCardTracker.zero
    
    /// Draw three cards from availableCards and move to displayedCards, if available.
    /// If 3 cards are not available, do nothing.
    mutating func drawThreeCards() {
        if threeOrMoreCardsLeft {
            switch selectedCardTracker {
            case let .three(indexOfCard1, indexOfCard2, indexOfCard3):
                if selectedCardsMatch {
                    replaceThreeCardsAt(index1: indexOfCard1, index2: indexOfCard2, index3: indexOfCard3)
                }
                selectedCardsMatch = false
                selectedCardTracker = .zero
                
            default:
                displayedCards.append(availableCards.removeLast())
                displayedCards.append(availableCards.removeLast())
                displayedCards.append(availableCards.removeLast())
            }
        }
    }
    
    /// Pick the index'th display card
    mutating func pickDisplayedCard(at indexOfSelectedCard: Int) {
        switch selectedCardTracker {
        
        case .zero:
            selectedCardTracker = .one(indexOfSelectedCard)
            
        case let .one(indexOfCard1):
            if displayedCards[indexOfSelectedCard] != displayedCards[indexOfCard1] {
                selectedCardTracker = .two(indexOfCard1,indexOfSelectedCard)
            } else {
                selectedCardTracker = .zero
            }
            
        case let .two(indexOfCard1, indexOfCard2):
            if displayedCards[indexOfSelectedCard] == displayedCards[indexOfCard1] {
                selectedCardTracker = .one(indexOfCard2)
            } else if displayedCards[indexOfSelectedCard] == displayedCards[indexOfCard2] {
                selectedCardTracker = .one(indexOfCard1)
            } else {
                selectedCardTracker = .three(indexOfCard1,indexOfCard2,indexOfSelectedCard)
                
                selectedCardsMatch = Card.formsASet(card1: displayedCards[indexOfCard1],
                                            card2: displayedCards[indexOfCard2],
                                            card3: displayedCards[indexOfSelectedCard])
                
                score += selectedCardsMatch ? 5 : -3

            }
            
        case let .three(indexOfCard1, indexOfCard2, indexOfCard3):
            if displayedCards[indexOfSelectedCard] != displayedCards[indexOfCard1],
               displayedCards[indexOfSelectedCard] != displayedCards[indexOfCard2],
               displayedCards[indexOfSelectedCard] != displayedCards[indexOfCard3] {
                
                let selectedCard = displayedCards[indexOfSelectedCard]
                
                if selectedCardsMatch {
                    replaceThreeCardsAt(index1: indexOfCard1, index2: indexOfCard2, index3: indexOfCard3)
                }
                    
                selectedCardTracker = .one(displayedCards.firstIndex(of: selectedCard)!)
                selectedCardsMatch = false
            }
        }
    }
    
    mutating private func replaceThreeCardsAt(index1: Int, index2: Int, index3: Int){
        if threeOrMoreCardsLeft {
            matchedCards.append(displayedCards.remove(at: index1))
            displayedCards.insert(availableCards.removeLast(), at: index1)
            matchedCards.append(displayedCards.remove(at: index2))
            displayedCards.insert(availableCards.removeLast(), at: index2)
            matchedCards.append(displayedCards.remove(at: index3))
            displayedCards.insert(availableCards.removeLast(), at: index3)
        } else {
            let cardAtIndex1 = displayedCards[index1]
            let cardAtIndex2 = displayedCards[index2]
            let cardAtIndex3 = displayedCards[index3]
            
            matchedCards.append(displayedCards.remove(at: displayedCards.firstIndex(of: cardAtIndex1)!))
            matchedCards.append(displayedCards.remove(at: displayedCards.firstIndex(of: cardAtIndex2)!))
            matchedCards.append(displayedCards.remove(at: displayedCards.firstIndex(of: cardAtIndex3)!))
        }
}
    
    /// Load 81 unique set cards into availableCards
    init() {
        // Add 81 unique cards to deck and shuffle them
        for number in Card.Number.all {
            for shape in Card.Shape.all {
                for shading in Card.Shading.all {
                    for color in Card.Color.all {
                        availableCards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        availableCards.shuffle()
        
        // Draw 12 cards to deck
        for _ in 0..<12 {
            displayedCards.append(availableCards.removeLast())
        }
    }
    
}

extension Array {
    /// Shuffles the elements in an array by swapping random pairs 'self.count' times, if self.count >= 3
    mutating func shuffle() {
        let numberOfElements = self.count
        if numberOfElements >= 3 {
            for _ in 1..<numberOfElements {
                let randomIndexA = Int(arc4random_uniform(UInt32(numberOfElements)))
                let randomIndexB = Int(arc4random_uniform(UInt32(numberOfElements)))
                self.swapAt(randomIndexA, randomIndexB)
            }
        }
    }
    
}
