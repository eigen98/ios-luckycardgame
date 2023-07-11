//
//  CardContainerView.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/06.
//

import Foundation
import UIKit
class CardContainerView : UIView{
    
    //컨테이너 Layout 상수
    enum ContainerSize{
        static let LEFT_INSET = 16.0
        static let RIGTH_INSET = 16.0
        static let LABEL_WIDTH = 80.0
        static let CORNER_RADIUS = 10.0
    }
    
    //카드 Layout 상수
    enum CardSize{
        static let CARD_HEIGHT = 75.0
    }
    
    //플레이어 이름 Label
    private let playerNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .gray
        label.alpha = 0.5
        
        return label
    }()
    
    private var name : String = ""
    
    init(playerName: String) {
        super.init(frame: .zero)
        name = playerName
        attribute()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //카드 덱 컨테이너 뷰 레이아웃 초기화
    func layout(){
        self.addSubview(playerNameLabel)
        playerNameLabel.frame = CGRect(x: ContainerSize.LEFT_INSET,
                                       y: 0,
                                       width: ContainerSize.LABEL_WIDTH,
                             height: self.frame.height)
        
       
    }
    
    //UI Property
    private func attribute(){
        playerNameLabel.text = name
        self.backgroundColor =  Colors.player_container_colors
        self.layer.cornerRadius = ContainerSize.CORNER_RADIUS
        self.clipsToBounds = true
        
        
    }
    
}

//MARK: 카드 배치 로직
extension CardContainerView{
   
    //카드뷰 레이아웃 초기화.
    func layoutCardViews(cards : [Card], isFront: Bool){
        var cardViews = [CardView]()
        
        // 뷰의 하위 뷰 모두 제거
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        for card in cards {
            let newCardView = CardView()
            newCardView.configureWithCard(card)
            cardViews.append(newCardView)
        }
        
        var leftCardInset :CGFloat = 8.0
        let availableWidth :CGFloat  = self.frame.width - 16.0
        let cardWidth = availableWidth / 6.0
        let sumOfCardWidth = cardWidth * CGFloat(cardViews.count) //여백없이 카드 가로 길이 전체 합
        
        let spacing = (availableWidth - sumOfCardWidth) / CGFloat(cardViews.count - 1)
        
        for idx in 0..<cardViews.count{
            let card = cardViews[idx]
            self.addSubview(card)
            card.frame = CGRect(x: leftCardInset, y: (self.frame.height - 75.0) / 2.0  , width: cardWidth, height: CardSize.CARD_HEIGHT )
            isFront ?  card.layoutFront() : card.layoutBack()
            leftCardInset +=  cardWidth + spacing
        }

    }
    
    
}
