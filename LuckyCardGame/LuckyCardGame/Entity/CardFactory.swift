//
//  CardFactory.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation
//카드 객체를 생성하는 클래스
class CardFactory {
    
    //MARK: 만든 이유
    // 개임이 시작되었을 때 처음 Deck에서 모든 카드가 생성되는데 Deck은 카드를 관리하는 역할만 수행하므로
    //CardFactory가 카드를 생성하는 역할을 담당하도록 구현하였습니다.
    
    //현재 카드 타입의 종류들을 반환한다.
    static func allTypes() -> [CardType] {
        return [Dog(), Cat(), Cow()]
    }
    
    //새로운 덱을 반환
    static func newDeck() -> [LuckyCard] {
        var cards: [LuckyCard] = []
        for type in allTypes() {
            for number in 1...12 {
                let card = LuckyCard(number: number, type: type)
                cards.append(card)
            }
        }
        return cards
    }
    
}
