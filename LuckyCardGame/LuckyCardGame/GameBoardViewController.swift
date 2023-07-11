//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/04.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    
    //SafeArea 크기 정보
    struct SafeAreaFrame {
        let LEFT_INSET: CGFloat
        let RIGHT_INSET: CGFloat
        let TOP_INSET: CGFloat
        let BOTTOM_INSET: CGFloat
        let WIDTH: CGFloat
        let HEIGHT: CGFloat
    }
    
    enum LayoutConstants {
        static let MARGIN: CGFloat = 10.0
        static let SEGMENT_HEIGHT: CGFloat = 44.0
        static let CORNER_RADIUS : CGFloat = 10.0
    }
    
    //Game Service 객체
    private let gameService: GameService = GameService(mode: .threePlayer)

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
    
    //컨테이너 뷰 배열
    private var cardContainers: [CardContainerView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        layout()
    }
    
    //MARK: 뷰 레이아웃
    private func layout(){
        
        //cardContainers 카드 컨테이너 뷰 배열 초기화
        for i in 0..<5 {
            let playerName = String(UnicodeScalar(65 + i)!)
            let container = CardContainerView(playerName: playerName)
            cardContainers.append(container)
            self.view.addSubview(container)
        }
        
        [containerSegmentView, containerBottomView]
            .forEach{
                self.view.addSubview($0)
            }
        
        let safeAreaFrame = calculateSafeAreaFrame()
        //세그먼트 뷰 레이아웃 초기화
        layoutSegmentView(with: safeAreaFrame)
        //카드 컨테이너 뷰 레이아웃 초기화
        layoutCardContainers(with: safeAreaFrame, playerCount: gameService.getPlyerCount())
        // 바닥 영역 뷰 레이아웃 초기화.
        layoutBottomView(with: safeAreaFrame, playerCount: gameService.getPlyerCount())
        
    }
    //MARK: 뷰 속성
    private func attribute(){
        //SegmentControl 설정
        containerSegmentView.backgroundColor = Colors.segment_color
        containerSegmentView.layer.cornerRadius = LayoutConstants.CORNER_RADIUS
        containerSegmentView.clipsToBounds = true
        
    }
    
    //세그먼트 클릭 이벤트 함수
    @objc private func tapSegmentButton(_ sender: UISegmentedControl){
        let selectedIndex = sender.selectedSegmentIndex
        let gameMode = GameMode.fromSegmentIndex(selectedIndex) //game mode
        updateGameMode(gameMode: gameMode)
    }
    
    //게임 모드(플레이어 수) 변경 이벤트 함수
    private func updateGameMode(gameMode : GameMode){
        gameService.changeMode(mode: GameMode(rawValue: gameMode.playerCount) ?? .threePlayer)
        for (index, container) in cardContainers.enumerated() {
            if index < gameMode.playerCount{
                let cards =  gameService.getPlayerDeck(at: index) ?? []
                container.layoutCardViews(cards: cards, isFront: index == 0 ? true : false)
            }
            container.isHidden = gameMode.isVisiblePlayer(index)
        }
        
        let safeAreaFrame = calculateSafeAreaFrame()
        layoutBottomView(with: safeAreaFrame, playerCount: gameMode.playerCount)
        containerBottomView.configureBottomCardsGrid(cards: gameService.getBottomDeck())
    }
}

//Layout
extension GameBoardViewController{
    
    
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
    
    // SegmentView 레이아웃 설정
    private func layoutSegmentView(with safeAreaFrame: SafeAreaFrame) {
        containerSegmentView.frame = CGRect(x: safeAreaFrame.LEFT_INSET,
                                            y: safeAreaFrame.TOP_INSET,
                                            width: safeAreaFrame.WIDTH,
                                            height: LayoutConstants.SEGMENT_HEIGHT)
        containerSegmentView.addSubview(segmentContolView)
        segmentContolView.frame = containerSegmentView.bounds
        segmentContolView.addTarget(self, action: #selector(tapSegmentButton), for: .valueChanged)
    }
    
    // CardContainers(플레이어 별 카드 컨테이너 A B C D E) Layout 초기화
    private func layoutCardContainers(with safeAreaFrame: SafeAreaFrame, playerCount : Int) {
        let margin = 10.0
        let availableHeight = safeAreaFrame.HEIGHT - containerSegmentView.frame.height - margin * 6
        let cardAreaHeight = (availableHeight / 6)
        var yOffset = containerSegmentView.frame.maxY + margin
        
        
        
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
            if index < gameService.getMode().rawValue{
                //각 컨테이너 카드 배치
                let cards =  gameService.getPlayerDeck(at: index) ?? []
                container.layoutCardViews(cards: cards, isFront: index == 0 ? true : false)
            }
            
            //필요한 플레이어 덱만 보이기
        
            container.isHidden = gameService.getMode().isVisiblePlayer(index)
        }
        
    }
    
    // 바닥 영역 Layout 초기화
    private func layoutBottomView(with safeAreaFrame: SafeAreaFrame, playerCount : Int) {
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
        containerBottomView.configureBottomCardsGrid(cards: gameService.getBottomDeck())
    }
}

