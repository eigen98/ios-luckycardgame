//
//  GameService.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/09.
//

import Foundation

class LuckyGame {
    
    var gameManager: GameManager
    
    init(mode: GameMode) {
        //첫 시작시 3인 게임모드 디폴트 값.
        self.gameManager = GameManager(mode: .threePlayer)
        
        gameStart(mode: mode)
        
    }
    
    //게임 시작
    func gameStart(mode : GameMode) {
        
        gameManager.initializePlayersAccordingToMode(mode: mode)
        gameManager.prepareDealer(mode: mode)
        gameManager.distributeCards()
        
    }
    
    //게임 모드 변경.
    func changeMode(mode : GameMode){
        self.gameManager = GameManager(mode: mode)
        gameStart(mode: mode)
    }
    
    //현재 참여 인원 반환 함수
    func getPlyerCount() -> Int{
        return gameManager.getPlayerCount()
    }
    
    func getPlayerDeck(at index: Int) -> [Card]? {
        return gameManager.getPlayerDeck(at: index)
    }
    
    func getBottomDeck() -> [Card]{
        return gameManager.getBottomCard()
    }
    
    func getMode() -> GameMode{
        return gameManager.getMode()
    }
    
    func setMode(mode : GameMode){
        gameManager.setMode(mode: mode)
    }
    
    
}
