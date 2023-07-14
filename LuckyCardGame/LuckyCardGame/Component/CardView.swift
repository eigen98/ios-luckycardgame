//
//  CardView.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/06.
//

import UIKit
import Foundation
//카드 뷰
class CardView : UIView{
    
    enum CardSize{
        static let CORNER_RADIUS = 10.0
        static let BORDER_WIDTH = 1.0
        static let CARD_INSET = 6.0
        static let LABEL_WIDTH = 20.0
        static let LABEL_HEIGHT = 20.0
    }
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_img")
        return imageView
    }()
    
    private let shapeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    //상단 숫자 라벨
    private let topLabel : UILabel = {
        let numLabel = UILabel()
        numLabel.font = .systemFont(ofSize: 15, weight: .bold)
        return numLabel
    }()
    
    //하단 숫자 라벨
    private let botLabel : UILabel = {
        let numLabel = UILabel()
        numLabel.font = .systemFont(ofSize: 15, weight: .bold)
        return numLabel
    }()
    
    private var card: Card?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        
    }
    
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
        attribute()
            
    }
    
    //카드 앞면 레이아웃 초기화
    func layoutFront(){
        self.addSubview(topLabel)
        self.addSubview(botLabel)
        self.addSubview(shapeLabel)
        
        
        shapeLabel.sizeToFit()
        self.shapeLabel.frame = CGRect(x: self.bounds.midX - shapeLabel.bounds.width / 2,
                                       y: self.bounds.midY - shapeLabel.bounds.height / 2,
                                       width: shapeLabel.frame.width,
                                       height: shapeLabel.frame.height)
        
        topLabel.frame = CGRect(x: self.bounds.minX + CardSize.CARD_INSET,
                                y: self.bounds.minY + CardSize.CARD_INSET,
                                width: CardSize.LABEL_WIDTH,
                                height: CardSize.LABEL_HEIGHT)
        botLabel.sizeToFit()
        
        botLabel.frame = CGRect(x: self.bounds.maxX - botLabel.frame.width  - CardSize.CARD_INSET ,
                                y: self.bounds.maxY - CardSize.LABEL_HEIGHT - CardSize.CARD_INSET,
                                width: CardSize.LABEL_WIDTH, height: CardSize.LABEL_HEIGHT)
        
        
        
        
    }
    
    //카드 뒷면 레이아웃 초기화
    func layoutBack(){
        self.addSubview(logoImageView)
        //LOGO 이미지 레이아웃
        logoImageView.frame = .init(x:  self.bounds.midX - 15, y: self.bounds.midY - 15, width: 30, height: 30)
    }
    
    //UI Property
    private func attribute(){
        
        self.layer.cornerRadius = CardSize.CORNER_RADIUS
        self.layer.borderWidth = CardSize.BORDER_WIDTH
        self.layer.borderColor = .init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        self.backgroundColor = .white
        
    }
    
    
    func configureWithCard(_ card: Card) {
        
        self.card = card
        self.topLabel.text = "\(card.number.rawValue)"
        self.botLabel.text = "\(card.number.rawValue)"
        self.shapeLabel.text = "\(card.type.icon)"
        
    }
    
}
