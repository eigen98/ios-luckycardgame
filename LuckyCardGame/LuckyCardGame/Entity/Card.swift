//
//  Card.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation
// 카드의 기본 특성을 정의하는 프로토콜
protocol Card {
    var number: Int { get } // 숫자.
    var type: CardType { get } //카드 종류
    var cardState : CardFace{ get set} //카드 앞뒷면 상태
   
}

enum CardFace {
    case front
    case back
}
