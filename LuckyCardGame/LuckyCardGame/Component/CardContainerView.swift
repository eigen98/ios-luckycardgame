//
//  CardContainerView.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/06.
//

import Foundation
import UIKit
class CardContainerView : UIView{
    var label =  UILabel()
    var name : String = ""
    
    
    init(playerName: String) {
        super.init(frame: .zero)
        name = playerName
        attribute()
        
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            
    }
    
    func layout(){
        self.addSubview(label)
        label.frame = CGRect(x: 16, y: 0, width: 80, height: self.frame.height)
    }
    
    private func attribute(){
        label.text = name
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .gray
        label.alpha = 0.5
        
        self.backgroundColor =  Colors.player_container_colors
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        
    }
    
}
