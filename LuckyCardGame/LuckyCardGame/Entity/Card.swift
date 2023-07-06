//
//  Card.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation
// 카드의 기본 특성을 정의하는 프로토콜
protocol Card {
    var number: CardNumber { get } // 숫자.
    var type: CardType { get } //카드 종류
    var cardState : CardFace{ get set} //카드 앞뒷면 상태
   
}

enum CardFace {
    case front
    case back
}

enum CardNumber : Int, CaseIterable{
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
}
