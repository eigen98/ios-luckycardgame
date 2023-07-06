//
//  Deck.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation

//플레이어에게 나누어줄 카드를 담당하는 클래스
class Deck{
    private var cards: [LuckyCard]
    
    init() {
        cards = CardFactory.newDeck()
    }
    
    //덱의 카드를 섞음
    func shuffle() {
        cards.shuffle()
    }
    
    //마지막 카드를 가져옴
    func deal() -> LuckyCard? {
        let topCard = cards.popLast()
        return topCard
    }
    // 덱의 카드 수를 반환
    func count() -> Int {
        return cards.count
    }
}
