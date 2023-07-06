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


enum Animal: CardType, CaseIterable {
    case dog, cat, cow

    var icon: String {
        switch self {
        case .dog:
            return "🐶"
        case .cat:
            return "🐱"
        case .cow:
            return "🐮"
        }
    }
    
    
}

