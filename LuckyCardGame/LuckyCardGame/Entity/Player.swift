//
//  Player.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/06.
//

import Foundation

struct Player{
    var name : String
    var playerDeck : [Card]
    
    mutating func drawCard(cards : [Card]){
        playerDeck.append(contentsOf: cards)
    }
}

