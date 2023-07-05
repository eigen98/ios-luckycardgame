//
//  LuckyCard.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation
//카드 클래스
class LuckyCard : Card{
    //MARK: 카드 종류로 CardType을 선언한 이유
    //
    //A. 확장성
    // 동물마다 다른 효과, 다양한 특성을 가지게 될 경우 CardType을 채택한 해당 Struct만 추가하면 되기 때문.
    
    //MARK: 카드 상태로 열거형을 선언한 이유
    //A. 가독성, 타입 안정성
    //자체적으로 의미가 있고 .front'와 '.back' 두 가지로 명확하게 제한하여 실수를 방지
    
    
    let number: Int // 카드 넘버
    let type: CardType // 카드 종류
    var cardState: CardFace //앞면 뒷면 상태
    
    init(number: Int, type: CardType) {
        self.number = number
        self.type = type
        self.cardState = .back
    }
    
}
