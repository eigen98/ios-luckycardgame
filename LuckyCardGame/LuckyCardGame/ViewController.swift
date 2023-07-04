//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by KoJeongMin  on 2023/07/04.
//

import UIKit

class ViewController: UIViewController {
    
    var containerSegmentView = UIView()
    var containerAView = UIView()
    var containerBView = UIView()
    var containerCView = UIView()
    var containerDView = UIView()
    var containerEView = UIView()
    var containerBottomView = UIView()
    
    
    var labelA = UILabel()
    var labelB = UILabel()
    var labelC = UILabel()
    var labelD = UILabel()
    var labelE = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layout()
        attribute()
    }
    
    //MARK: 뷰 레이아웃
    func layout(){
//        SegmentControl
        view.addSubview(containerSegmentView)
        containerSegmentView.translatesAutoresizingMaskIntoConstraints = false
        containerSegmentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        containerSegmentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerSegmentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        containerSegmentView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //ABCDE 뷰 높이 구하기.
        let availableHeight = self.view.safeAreaLayoutGuide.layoutFrame.height - 54 - 10 * 6
        let viewHeight = (availableHeight / 7) - 10
        let bottomViewHeight =  viewHeight + 60 // remaining height
        
        //Bottom
        view.addSubview(containerBottomView)
        containerBottomView.translatesAutoresizingMaskIntoConstraints = false
        containerBottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        containerBottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerBottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        containerBottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight).isActive = true
        
        
//        A
        view.addSubview(containerAView)
        containerAView.translatesAutoresizingMaskIntoConstraints = false
        containerAView.topAnchor.constraint(equalTo: self.containerSegmentView.bottomAnchor, constant: 10).isActive = true
        containerAView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerAView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        containerAView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        containerAView.addSubview(labelA)
        labelA.translatesAutoresizingMaskIntoConstraints = false
        labelA.centerYAnchor.constraint(equalTo: self.containerAView.centerYAnchor).isActive = true
        labelA.leadingAnchor.constraint(equalTo: self.containerAView.leadingAnchor,constant: 16).isActive = true
        
        
        //B
        view.addSubview(containerBView)
        containerBView.translatesAutoresizingMaskIntoConstraints = false
        containerBView.topAnchor.constraint(equalTo: self.containerAView.bottomAnchor, constant: 10).isActive = true
        containerBView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerBView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        containerBView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        containerBView.addSubview(labelB)
        labelB.translatesAutoresizingMaskIntoConstraints = false
        labelB.centerYAnchor.constraint(equalTo: self.containerBView.centerYAnchor).isActive = true
        labelB.leadingAnchor.constraint(equalTo: self.containerBView.leadingAnchor,constant: 16).isActive = true
        
        //C
        view.addSubview(containerCView)
        containerCView.translatesAutoresizingMaskIntoConstraints = false
        containerCView.topAnchor.constraint(equalTo: self.containerBView.bottomAnchor, constant: 10).isActive = true
        containerCView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerCView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        containerCView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        containerCView.addSubview(labelC)
        labelC.translatesAutoresizingMaskIntoConstraints = false
        labelC.centerYAnchor.constraint(equalTo: self.containerCView.centerYAnchor).isActive = true
        labelC.leadingAnchor.constraint(equalTo: self.containerCView.leadingAnchor,constant: 16).isActive = true
        
        //D
        view.addSubview(containerDView)
        containerDView.translatesAutoresizingMaskIntoConstraints = false
        containerDView.topAnchor.constraint(equalTo: self.containerCView.bottomAnchor, constant: 10).isActive = true
        containerDView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerDView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        containerDView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        containerDView.addSubview(labelD)
        labelD.translatesAutoresizingMaskIntoConstraints = false
        labelD.centerYAnchor.constraint(equalTo: self.containerDView.centerYAnchor).isActive = true
        labelD.leadingAnchor.constraint(equalTo: self.containerDView.leadingAnchor,constant: 16).isActive = true
        
        //E
        view.addSubview(containerEView)
        containerEView.translatesAutoresizingMaskIntoConstraints = false
        containerEView.topAnchor.constraint(equalTo: self.containerDView.bottomAnchor, constant: 10).isActive = true
        containerEView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        containerEView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        containerEView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        containerEView.addSubview(labelE)
        labelE.translatesAutoresizingMaskIntoConstraints = false
        labelE.centerYAnchor.constraint(equalTo: self.containerEView.centerYAnchor).isActive = true
        labelE.leadingAnchor.constraint(equalTo: self.containerEView.leadingAnchor,constant: 16).isActive = true
        
       
        
        
        
        
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
        
        
        //A, B, C, D, E Container View
        [containerAView, containerBView, containerCView, containerDView, containerEView]
            .forEach{
                $0.backgroundColor =  Colors.player_container_colors
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = true
            }
        
        //ABCDE Label
        [labelA, labelB, labelC, labelD, labelE]
            .forEach{
                $0.font = .systemFont(ofSize: 40, weight: .heavy)
                $0.textColor = .gray
                $0.alpha = 0.5
            }
        
        labelA.text = "A"
        labelB.text = "B"
        labelC.text = "C"
        labelD.text = "D"
        labelE.text = "E"
       
    }
}

