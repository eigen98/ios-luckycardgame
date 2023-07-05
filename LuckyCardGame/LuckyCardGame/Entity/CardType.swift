//
//  CardType.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/05.
//

import Foundation
// 카드 동물 종류 프로토콜
protocol CardType {
    var icon: String { get }
}


struct Dog: CardType {
    let icon = "🐶"
}

struct Cat: CardType {
    let icon = "🐱"
}

struct Cow: CardType {
    let icon = "🐮"
}
