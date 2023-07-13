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
            sortPlayerDeck(at: playerIndex)
        }
        
        
        bottomDeck.append(contentsOf: dealer.deal(count: dealer.count()))
        sortBottomDeck()
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

    
    /*
     레이어의 카드 덱을 오름차순으로 정렬하는 함수
     index를 이용하여 해당 플레이어를 선택하고, 해당 플레이어의 카드 덱을 정렬
    */
    mutating func sortPlayerDeck(at index: Int) {
        guard players.indices.contains(index) else {
            return
        }
        players[index].playerDeck.sort(by: { $0.number.rawValue < $1.number.rawValue })
    }

    mutating func sortBottomDeck() {
        bottomDeck.sort(by: { $0.number.rawValue < $1.number.rawValue })
    }
    
    /*
     참가자 중에 같은 숫자 카드 3장을 가진 경우가 있는지 판단하는 함수
     카드들의 숫자별 개수를 세는 딕셔너리 생성하여 3개 이상의 카드를 가진 숫자가 있는지 확인
    */
    func hasTripleCardsInPlayers(player : Player) -> Bool {
        
        let counts = player.playerDeck.reduce(into: [CardNumber: Int]()) { counts, card in
            counts[card.number, default: 0] += 1
        }

        for count in counts.values {
            if count >= 3 {
                return true
            }
        }
        return false
    }
    
    
    
    /*
     플레이어의 (가장 높은, 가장 낮은)카드 선택
     */
    func selectCardFromPlayer(player : Player,  isHighest : Bool) -> Card?{
        let cardCount = player.playerDeck.count
        if cardCount == 0{
            return nil
        }
        if isHighest{
            return player.playerDeck[cardCount - 1]
        }else{
            return player.playerDeck[0]
        }
    }
    
    /*
     바닥 (가장 높은, 가장 낮은)카드 선택
     */
    func selectCardFromBottom(bottomDeck : [Card], isHighest : Bool) -> Card?{
        let cardCount = bottomDeck.count
        if cardCount == 0{
            return nil
        }
        if isHighest{
            return bottomDeck[cardCount - 1]
        }else{
            return bottomDeck[0]
        }
    }
    
    
    
}
