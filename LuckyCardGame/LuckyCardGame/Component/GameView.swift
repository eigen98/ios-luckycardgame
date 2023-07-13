//
//  GameView.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/13.
//

import Foundation
import UIKit

class GameView : UIView{
    
    enum LayoutConstants {
        static let MARGIN: CGFloat = 10.0
        static let SEGMENT_HEIGHT: CGFloat = 44.0
        static let CORNER_RADIUS : CGFloat = 10.0
    }
    
    //세그먼트 컨테이너 뷰
    private let containerSegmentView = {
       let view = UIView()
        return view
    }()
    
    //세그먼트 뷰
    private let segmentContolView = {
        let buttonTexts = ["3명", "4명", "5명"]
        let segmentControl =  UISegmentedControl(items: buttonTexts)
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    //바닥 영역 뷰
    private let containerBottomView = {
        let view = BottomContainerView()
        return view
    }()
    
    var segmentControlAction: ((Int) -> Void)?
    
    //컨테이너 뷰 배열
    private var cardContainers: [CardContainerView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: 뷰 레이아웃
    func layout(safeAreaFrame: SafeAreaFrame,
                gameMode: GameMode,
                playerDecks: [[Card]],
                bottomDeck: [Card]) {
        layoutSegmentView(with: safeAreaFrame)
        layoutCardContainers(with: safeAreaFrame, playerDecks: playerDecks)
        
        for (index, container) in cardContainers.enumerated() {
            
            let cards = playerDecks[index]
            container.layoutPlayerNameView()
            container.layoutCardViews(cards: cards, isFront: index == 0 ? true : false)
            container.isHidden = GameMode(rawValue: playerDecks.count)?.isVisiblePlayer(index) ?? true
        }
        layoutBottomView(with: safeAreaFrame, playerCount: playerDecks.count, bottomDeck: bottomDeck)
        containerBottomView.configureBottomCardsGrid(cards: bottomDeck)
    }
    
    

    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        segmentControlAction?(sender.selectedSegmentIndex)
    }
    

    
}

// Layout 관련
extension GameView{
    // SegmentView 레이아웃 설정
    private func layoutSegmentView(with safeAreaFrame: SafeAreaFrame) {
        containerSegmentView.frame = CGRect(x: safeAreaFrame.LEFT_INSET,
                                            y: safeAreaFrame.TOP_INSET,
                                            width: safeAreaFrame.WIDTH,
                                            height: LayoutConstants.SEGMENT_HEIGHT)
        containerSegmentView.addSubview(segmentContolView)
        segmentContolView.frame = containerSegmentView.bounds
        segmentContolView.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
    }
    
    // CardContainers(플레이어 별 카드 컨테이너 A B C D E) Layout 초기화
    private func layoutCardContainers(with safeAreaFrame: SafeAreaFrame, playerDecks: [[Card]]){
        let margin = 10.0
        let availableHeight = safeAreaFrame.HEIGHT - containerSegmentView.frame.height - margin * 6
        let cardAreaHeight = (availableHeight / 6)
        var yOffset = containerSegmentView.frame.maxY + margin
        
        //cardContainers 카드 컨테이너 뷰 배열 초기화
        cardContainers.forEach { $0.removeFromSuperview() }
        cardContainers = []
        for i in 0..<playerDecks.count {
            let playerName = String(UnicodeScalar(65 + i)!)
            let container = CardContainerView(playerName: playerName)
            cardContainers.append(container)
            self.addSubview(container)
        }
        [containerSegmentView, containerBottomView]
            .forEach{
                self.addSubview($0)
            }
        
        cardContainers.forEach{
            //각 컨테이너 Frame 초기화
            $0.frame = CGRect(x: safeAreaFrame.LEFT_INSET,
                              y: yOffset,
                              width: safeAreaFrame.WIDTH,
                              height: cardAreaHeight)
            //margin만큼 offset증가.
            yOffset += cardAreaHeight + margin
        }
        
        for (index, container) in cardContainers.enumerated() {
            if index < playerDecks.count{
                //각 컨테이너 카드 배치
                let cards =  playerDecks[index]
                container.layoutPlayerNameView()
                container.layoutCardViews(cards: cards, isFront: index == 0 ? true : false)
            }
            
        }
        
    }
    
    // 바닥 영역 Layout 초기화
    private func layoutBottomView(with safeAreaFrame: SafeAreaFrame,playerCount : Int , bottomDeck : [Card]) {
        let margin = 10.0
        let availableHeight = safeAreaFrame.HEIGHT - containerSegmentView.frame.height
        let cardAreaHeight = (availableHeight / 6) - margin
        
        var bottomViewHeight =  cardAreaHeight * 2
        switch playerCount {
        case 5:
            bottomViewHeight = cardAreaHeight
        default:
            bottomViewHeight = cardAreaHeight * 2 + 10
        }
        //바닥 영역 뷰 Frame 초기화
        containerBottomView.frame = CGRect(x: safeAreaFrame.LEFT_INSET,
                                           y: safeAreaFrame.HEIGHT + safeAreaFrame.TOP_INSET - bottomViewHeight,
                                           width: safeAreaFrame.WIDTH,
                                           height: bottomViewHeight)
        //바닥 영역 카드 배치
        containerBottomView.configureBottomCardsGrid(cards: bottomDeck)
    }
}
