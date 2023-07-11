//
//  GameManager.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/09.
//

import Foundation
//게임 현황
struct GameManager{
    
    
  
    private var players: [Player]
    private var bottomDeck: [LuckyCard]
    private var dealer: Dealer
    private var mode: GameMode
    
    init(mode: GameMode) {
        self.players = [Player]()
        self.bottomDeck = [LuckyCard]()
        self.dealer = Dealer()
        self.mode = mode

    }
    
    //카드 나눠주기
    mutating func distributeCards() {
        
        let cardsPerPlayer = mode.cardCount
        for playerIndex in players.indices {
            let cards = dealer.deal(count: cardsPerPlayer)
            players[playerIndex].playerDeck.append(contentsOf: cards)
        }

        bottomDeck.append(contentsOf: dealer.deal(count: dealer.count()))
    }
    
    //플레이어 입장
    mutating func initializePlayersAccordingToMode(mode : GameMode){
        
        for i in 1...mode.rawValue {
            let playerName = String(UnicodeScalar(65 + i) ?? "A")
            self.players.append(Player(name: "\(playerName)", playerDeck: []))
        }
    }
    
    //딜러 준비
    func prepareDealer(mode: GameMode){
        
        self.dealer.initializeCardsForGameMode(mode: mode)
        self.dealer.shuffle()
    }
    //해당 플레이어의 카드 가져오기 함수
    func getPlayerDeck(at index: Int) -> [Card]? {
        guard players.indices.contains(index) else {
            return nil
        }
        return players[index].playerDeck
    }
    //플레이어 인원수 반환 함수
    func getPlayerCount() -> Int{
        return players.count
    }
    
    func getBottomCard() -> [Card]{
        return bottomDeck
    }
    
    func getMode() -> GameMode{
        return mode
    }
    
    mutating func setMode(mode: GameMode){
        self.mode = mode
    }
    
    
}
