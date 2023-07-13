//
//  LuckyCardGameTests.swift
//  LuckyCardGameTests
//
//  Created by KoJeongMin  on 2023/07/04.
//

import XCTest
@testable import LuckyCardGame

final class LuckyCardGameServiceTests: XCTestCase {
    
    var luckyGame: LuckyGame!
    
    
    override func setUp() {
        super.setUp()
        luckyGame = LuckyGame(mode: .threePlayer) // Use your appropriate GameMode
    }
    
    
    //참가자수를 지정하고 게임을 초기화하면 적절하게 카드를 나눠줘야 한다
    func testCardDistribution() {
        for i in 0..<luckyGame.getPlyerCount() {
            let playerDeck = luckyGame.getPlayerDeck(at: i)
            XCTAssertNotNil(playerDeck)
            XCTAssertEqual(playerDeck?.count, 8)
        }
    }
    
    //모든 플레이어의 카드 덱이 오름차순으로 정렬되어 있는지 테스트
    func testPlayerDeckSorting() {
        for i in 0..<luckyGame.getPlyerCount() {
            guard let playerDeck = luckyGame.getPlayerDeck(at: i) else {
                XCTFail("플레이어의 덱이 존재하지 않습니다.")
                break
            }
            var previousCardNumber = 0
            for card in playerDeck.dropFirst() {
                XCTAssertGreaterThanOrEqual(card.number.rawValue, previousCardNumber)
                previousCardNumber = card.number.rawValue
            }
        }
    }
    //A만 정렬한 경우?
    
    // 바닥 덱 정렬 테스트: 바닥에 깔린 카드 덱이 오름차순으로 정렬되어있는지 테스트
    func testBottomDeckSorting() {
        let bottomDeck = luckyGame.getBottomDeck()
        var previousCardNumber = 0
        for card in bottomDeck.dropFirst() {
            XCTAssertGreaterThanOrEqual(card.number.rawValue, previousCardNumber)
            previousCardNumber = card.number.rawValue
        }
    }
//
   

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
