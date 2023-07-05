//
//  Deck.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation

//플레이어에게 나누어줄 카드를 담당하는 클래스
class Deck{
    var cards: [LuckyCard]
    
    init() {
        cards = CardFactory.newDeck()
    }
    
    //덱의 카드를 섞음
    func shuffle() {
        cards.shuffle()
    }
    
    //마지막 카드를 가져옴
    func deal() -> LuckyCard? {
        if let topCard = cards.popLast(){
            return topCard
        }else{
            print("카드가 없습니다.")
            return nil
        }
        
    }
    // 덱의 카드 수를 반환
    func count() -> Int {
        return cards.count
    }
}
