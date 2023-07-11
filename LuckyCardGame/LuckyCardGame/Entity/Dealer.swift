//
//  Deck.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation

//플레이어에게 나누어줄 카드를 담당하는 클래스
class Dealer{
    private var cards: [LuckyCard]
    
    init() {
        cards = []
    }
    
    //게임에서 사용될 카드를 준비
    func initializeCardsForGameMode(mode :GameMode){
        cards = CardFactory.newDeck(mode: mode)
    }
    
    //덱의 카드를 섞음
    func shuffle() {
        cards.shuffle()
    }
    
    //원하는 만큼 카드를 뽑는다.
    func deal(count : Int) -> [LuckyCard] {
        var cardList = [LuckyCard]()
        for _ in 0..<count{
            if let topCard = cards.popLast(){
                cardList.append(topCard)
            }
        }
        return cardList
    }
    
    // 덱의 카드 수를 반환
    func count() -> Int {
        return cards.count
    }
}
