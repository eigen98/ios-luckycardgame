//
//  BottomContainerView.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/07.
//

import Foundation
import UIKit

class BottomContainerView : UIView{
    
    private let cardHeight = 75.0
    private var cardViews = [CardView]()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewAttributes()
    }
    
    //View Attribute 초기화
    func configureViewAttributes(){
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    //바닥 영역 카드 배치
    func configureBottomCardsGrid(cards : [Card]){
        //기존 카드뷰 제거
        removeAllSubViewsAndCards()
        //카드뷰 초기화
        initializeCardViews(cards: cards)
        
        if cards.count <= 6 {
            //6장 이하 카드 배치
            setGridForSixOrLessCards(cardNum: cards.count)
        } else {
            
            // 6장 초과 카드 배치
            setGridForMoreThanSixCards(cardNum: cards.count)
        }
        
    }
    
    
    
}


//MARK: 카드 배치 로직
extension BottomContainerView{
    
  
    private func removeAllSubViewsAndCards() {
        cardViews.removeAll()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func initializeCardViews(cards: [Card]) {
        for idx in 0..<cards.count{
            let newCard = CardView()
            cardViews.append(newCard)
            newCard.configureWithCard(cards[idx])
            
        }
    }
    
    private func setGridForSixOrLessCards(cardNum: Int) {
        var leftCardInset : CGFloat = 8.0
        let availableWidth :CGFloat  = self.frame.width - 16.0
        let cardWidth = availableWidth / 6.0
        let sumOfCardWidth = cardWidth * CGFloat(cardViews.count)
        let spacing = (availableWidth - sumOfCardWidth) / CGFloat(cardViews.count - 1)
        let rowCount = cardNum / 5 + (cardNum % 5 > 0 ? 1 : 0)
        
        for index in 0..<cardViews.count{
            let cardView = cardViews[index]
            let lineSpacing = (self.frame.height - cardHeight) / CGFloat(rowCount)
            cardView.frame = CGRect(x: leftCardInset, y: lineSpacing , width: cardWidth, height: cardHeight)
            leftCardInset +=  cardWidth + spacing
            self.addSubview(cardView)
            cardView.layoutBack()
            
        }
    }
    
    private func setGridForMoreThanSixCards(cardNum: Int) {
        let colCount = cardNum > 8 ? 5 : 4
        let rowCount = cardNum / colCount + (cardNum % colCount > 0 ? 1 : 0)
        let cardWidth = (self.frame.width - 16.0) / 6.0
        for index in 0..<cardNum {
            let row = index / colCount
            let col = index % colCount
            let gridSpacing = (self.frame.width - cardWidth * CGFloat(colCount)) / CGFloat(colCount + 1)
            let lineSpacing = (self.frame.height - cardHeight * CGFloat(rowCount)) / CGFloat(rowCount + 1)
            let leftX = (cardWidth + gridSpacing) * CGFloat(col) + gridSpacing
            let leftY = (cardHeight + lineSpacing) * CGFloat(row) + lineSpacing
            let cardView = cardViews[index]
            cardView.frame = CGRect(x: leftX, y: leftY, width: cardWidth, height: cardHeight)
            self.addSubview(cardView)
            cardView.layoutBack()
            
        }
    }
    
}
