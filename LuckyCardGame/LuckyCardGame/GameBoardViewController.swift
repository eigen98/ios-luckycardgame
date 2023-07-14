//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/04.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    
    
    //Game Service 객체
    private let luckyGame: LuckyGame = LuckyGame(mode: .threePlayer)
    
    private let gameView : GameView = {
        let view = GameView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        layout()
    }
    
    private func layout(){
        let safeAreaFrame = calculateSafeAreaFrame()
        self.view.addSubview(gameView)
        gameView.frame = self.view.bounds
        
        let gameMode = luckyGame.getMode()
        let playerCount = gameMode.rawValue
        let playerDecks = (0..<playerCount).map { luckyGame.getPlayerDeck(at: $0) ?? [] }
        let bottomDeck = luckyGame.getBottomDeck()
        gameView.layout(safeAreaFrame: safeAreaFrame,
                        gameMode: gameMode,
                        playerDecks: playerDecks,
                        bottomDeck: bottomDeck)
        
        gameView.segmentControlAction = { [weak self] index in
            guard let self = self else { return }
            let gameMode = GameMode.fromSegmentIndex(index)
            self.luckyGame.changeMode(mode: gameMode)
            self.layout()
        }
    }
    
    
    
    // safe area frame 반환 함수
    private func calculateSafeAreaFrame() -> SafeAreaFrame {
        let rightInset =  self.view.safeAreaInsets.right + 16
        let leftInset =   self.view.safeAreaInsets.left + 16
        let topInset =   self.view.safeAreaInsets.top
        let bottomInset = self.view.safeAreaInsets.bottom
        let safeAreaWidth = UIScreen.main.bounds.size.width - leftInset - rightInset
        let safeAreaHeight = UIScreen.main.bounds.size.height - topInset - bottomInset
        
        return SafeAreaFrame(LEFT_INSET: leftInset,
                             RIGHT_INSET: rightInset,
                             TOP_INSET: topInset,
                             BOTTOM_INSET: bottomInset,
                             WIDTH: safeAreaWidth,
                             HEIGHT: safeAreaHeight)
    }
    
    
    
}
