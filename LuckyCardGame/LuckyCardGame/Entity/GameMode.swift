//
//  GameMode.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/09.
//

import Foundation

enum GameMode: Int, CaseIterable {
    case threePlayer = 3
    case fourPlayer = 4
    case fivePlayer = 5

    var playerCount: Int {
        switch self {
        case .threePlayer: return 3
        case .fourPlayer: return 4
        case .fivePlayer: return 5
        }
    }
    
    var cardCount: Int {
        switch self {
        case .threePlayer: return 8
        case .fourPlayer: return 7
        case .fivePlayer: return 6
        }
    }
    
    var bottomCardCount: Int {
        switch self {
        case .threePlayer: return 9
        case .fourPlayer: return 8
        case .fivePlayer: return 6
        }
    }
    
    static func fromSegmentIndex(_ index: Int) -> GameMode {
        switch index {
        case 0: return .threePlayer
        case 1: return .fourPlayer
        case 2: return .fivePlayer
        default: return .threePlayer
        }
    }
    
    func isVisiblePlayer(_ index: Int) -> Bool {
        switch self {
        case .threePlayer:
            return index >= 3
        case .fourPlayer:
            return index >= 4
        case .fivePlayer:
            return index >= 5
        }
    }
}

