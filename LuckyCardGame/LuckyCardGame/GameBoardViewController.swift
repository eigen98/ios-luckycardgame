//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/04.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    var containerSegmentView = UIView()
    var containerAView = CardContainerView(playerName: "A")
    var containerBView = CardContainerView(playerName: "B")
    var containerCView = CardContainerView(playerName: "C")
    var containerDView = CardContainerView(playerName: "D")
    var containerEView = CardContainerView(playerName: "E")
    var containerBottomView = UIView()
    
    
    var labelA = UILabel()
    var labelB = UILabel()
    var labelC = UILabel()
    var labelD = UILabel()
    var labelE = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        printCardClassResult()
        attribute()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        layout()
    }
    
    //MARK: 뷰 레이아웃
    func layout(){
        
        let rightInset = self.view.safeAreaInsets.right + 16
        let leftInset = self.view.safeAreaInsets.left + 16
        let topInset = self.view.safeAreaInsets.top
        let bottomInset = self.view.safeAreaInsets.bottom
        let safeAreaWidth = UIScreen.main.bounds.size.width - leftInset - rightInset
        let safeAreaHeight = UIScreen.main.bounds.size.height - topInset - bottomInset
        let margin = 10.0
        
        [containerSegmentView, containerBottomView, containerAView, containerBView, containerCView, containerDView, containerEView].forEach{
            self.view.addSubview($0)
        }
        //SegmentControl
        containerSegmentView.frame = CGRect(origin: .init(x: leftInset, y: topInset), size: .init(width: safeAreaWidth, height: 44.0))
 
        //ABCDE 뷰 높이 구하기.
        let availableHeight = self.view.safeAreaLayoutGuide.layoutFrame.height - margin * 6 - topInset - bottomInset
        let cardAreaHeight = (availableHeight / 6) - 10
        let bottomViewHeight =  cardAreaHeight + 50
        
        //Bottom
        containerBottomView.frame = CGRect(x: leftInset, y: safeAreaHeight - bottomViewHeight, width: safeAreaWidth, height: bottomViewHeight)
        
        //A
        containerAView.frame = CGRect(x: leftInset, y: containerSegmentView.frame.maxY + margin, width: safeAreaWidth, height: cardAreaHeight)
        containerAView.layout()
        
        //B
        containerBView.frame = CGRect(x: leftInset, y: containerAView.frame.maxY + margin, width: safeAreaWidth, height: cardAreaHeight)
        containerBView.layout()
        
        //C
        containerCView.frame = CGRect(x: leftInset, y: containerBView.frame.maxY + margin, width: safeAreaWidth, height: cardAreaHeight)
        containerCView.layout()
        
        //D
        containerDView.frame = CGRect(x: leftInset, y: containerCView.frame.maxY + margin, width: safeAreaWidth, height: cardAreaHeight)
        containerDView.layout()
        
        //E
        containerEView.frame = CGRect(x: leftInset, y: containerDView.frame.maxY + margin, width: safeAreaWidth, height: cardAreaHeight)
        containerEView.layout()
        
    }
    //MARK: 뷰 속성
    func attribute(){
        //SegmentControl
        containerSegmentView.backgroundColor = .yellow
        containerSegmentView.layer.cornerRadius = 10
        containerSegmentView.clipsToBounds = true
        
        //Bottom
        containerBottomView.backgroundColor = .gray
        containerBottomView.layer.cornerRadius = 10
        containerBottomView.clipsToBounds = true
        
    }
}

extension GameBoardViewController{
    
    //럭키 카드 클래스 구현하기 결과 출력 함수
    func printCardClassResult(){
        let allCards = Deck()
        allCards.shuffle()
        var cardList = [String]()
        for _ in 0...20{
            if let topCard = allCards.deal(){
                cardList.append("\(topCard.type.icon)\(String(format: "%02d", topCard.number.rawValue))")
            }
        }
        print(cardList.joined(separator: ", "))
    }
    
}

