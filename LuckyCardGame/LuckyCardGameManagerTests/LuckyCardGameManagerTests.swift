//
//  LuckyCardGameManagerTests.swift
//  LuckyCardGameManagerTests
//
//  Created by KoJeongMin  on 2023/07/12.
//

import XCTest
@testable import LuckyCardGame
final class LuckyCardGameManagerTests: XCTestCase {
    
    var gameManager: GameManager!
    var firstPlayer: Player!
    var secondPlayer: Player!
    var thirdPlayer: Player!
    var bottomDeck : [Card]!
    
    override func setUp() {
        super.setUp()
        gameManager = GameManager(mode: .threePlayer)
        
        let tripleCard = [LuckyCard(number: .one, type: Animal.cat),
                          LuckyCard(number: .ten, type: Animal.cat),
                          LuckyCard(number: .one, type: Animal.cat),
                          LuckyCard(number: .four, type: Animal.dog),
                          LuckyCard(number: .five, type: Animal.dog),
                          LuckyCard(number: .one, type: Animal.dog),
                          LuckyCard(number: .seven, type: Animal.dog),
                          LuckyCard(number: .eight, type: Animal.dog)
        ]
        let notTripleCard = [LuckyCard(number: .one, type: Animal.dog),
                             LuckyCard(number: .two, type: Animal.dog),
                             LuckyCard(number: .three, type: Animal.dog),
                             LuckyCard(number: .four, type: Animal.dog),
                             LuckyCard(number: .five, type: Animal.dog),
                             LuckyCard(number: .six, type: Animal.dog),
                             LuckyCard(number: .seven, type: Animal.dog),
                             LuckyCard(number: .eight, type: Animal.dog)
        ]
        firstPlayer = Player(name: "A", playerDeck: tripleCard)
        secondPlayer = Player(name: "B", playerDeck: notTripleCard)
        thirdPlayer = Player(name: "C", playerDeck: notTripleCard)
        
        bottomDeck = [LuckyCard(number: .one, type: Animal.dog),
                          LuckyCard(number: .two, type: Animal.cow),
                          LuckyCard(number: .three, type: Animal.cow),
                          LuckyCard(number: .four, type: Animal.cow),
                          LuckyCard(number: .five, type: Animal.dog),
                          LuckyCard(number: .six, type: Animal.dog),
                          LuckyCard(number: .seven, type: Animal.cat),
                          LuckyCard(number: .nine, type: Animal.cat),
                          LuckyCard(number: .nine, type: Animal.cat)]
    }

    
    func testHasTripleCardsInPlayers() throws {
        let gameManager = GameManager(mode: .threePlayer)
        //세장이상의 같은 카드가 있는 경우
        let tripleCard = [LuckyCard(number: .one, type: Animal.cat),
                          LuckyCard(number: .ten, type: Animal.cat),
                          LuckyCard(number: .one, type: Animal.cat),
                          LuckyCard(number: .four, type: Animal.cow),
                          LuckyCard(number: .five, type: Animal.dog),
                          LuckyCard(number: .one, type: Animal.cow),
                          LuckyCard(number: .seven, type: Animal.dog),
                          LuckyCard(number: .eight, type: Animal.cow)
     ]
        //세장이상의 같은 카드가 없는 경우
        let notTripleCard = [LuckyCard(number: .one, type: Animal.cow),
                             LuckyCard(number: .two, type: Animal.dog),
                             LuckyCard(number: .three, type: Animal.cat),
                             LuckyCard(number: .four, type: Animal.cow),
                             LuckyCard(number: .five, type: Animal.dog),
                             LuckyCard(number: .six, type: Animal.cow),
                             LuckyCard(number: .seven, type: Animal.dog),
                             LuckyCard(number: .eight, type: Animal.cow)
        ]
        
        let playerWithTripleCards = Player(name: "A",
                            playerDeck: tripleCard )
        
        let playerWithoutTripleCards = Player(name: "B",
                            playerDeck: notTripleCard)
        
        XCTAssertTrue(gameManager.hasTripleCardsInPlayers(player: playerWithTripleCards))
        XCTAssertFalse(gameManager.hasTripleCardsInPlayers(player: playerWithoutTripleCards))
    }
    
    /*
     특정 참가자와 해당 참가자 카드 중에 가장 낮은 숫자 또는 가장 높은 숫자, 바닥 카드 중 아무거나를 선택해서 3개가 같은지 판단
     */
    //플레이어들에게서 가장 작은 숫자 카드만 뽑는 경우 테스트
    func testPlayerOrBottomThreeLowestCardsEqual(){

       
        setupPlayersAndCardsForThreeCardsEqual()
        
        let firstSelectedCard = gameManager.selectCardFromPlayer(player: firstPlayer, isHighest: false)
        let secondSelectedCard = gameManager.selectCardFromPlayer(player: secondPlayer, isHighest: false)
        let thirdSelectedCard = gameManager.selectCardFromPlayer(player: thirdPlayer, isHighest: false)
        
        
        if let firstCard = firstSelectedCard, let secondCard = secondSelectedCard, let thirdCard = thirdSelectedCard {
            XCTAssertTrue(firstCard.number == secondCard.number && firstCard.number == thirdCard.number && secondCard.number == thirdCard.number)
        } else {
            XCTFail("가장 작은 숫자 카드만 뽑는 경우 실패")
        }
        
    }
    //플레이어들에게서 가장 큰 숫자 카드만 뽑는 경우 테스트
    func testPlayerOrBottomThreeHighestCardsEqual(){
        setupPlayersAndCardsForThreeCardsEqual()
        let firstSelectedCard = gameManager.selectCardFromPlayer(player: firstPlayer, isHighest: true)
        let secondSelectedCard = gameManager.selectCardFromPlayer(player: secondPlayer, isHighest: true)
        let thirdSelectedCard = gameManager.selectCardFromPlayer(player: thirdPlayer, isHighest: true)
        
        if let firstCard = firstSelectedCard, let secondCard = secondSelectedCard, let thirdCard = thirdSelectedCard {
            XCTAssertFalse(firstCard.number == secondCard.number && firstCard.number == thirdCard.number && secondCard.number == thirdCard.number)
        } else {
            XCTFail("")
        }
        
    }
    //플레이어들에게서 작은 숫자, 큰 숫자, 작은숫자 카드를 뽑는 경우 테스트
    func testPlayerOrBottomTwoLowestOneHighestCardsEqual(){
        setupPlayersAndCardsForThreeCardsEqual()
        let firstSelectedCard = gameManager.selectCardFromPlayer(player: firstPlayer, isHighest: false)
        let secondSelectedCard = gameManager.selectCardFromPlayer(player: secondPlayer, isHighest: true)
        let thirdSelectedCard = gameManager.selectCardFromPlayer(player: thirdPlayer, isHighest: false)
        
        
        if let firstCard = firstSelectedCard, let secondCard = secondSelectedCard, let thirdCard = thirdSelectedCard {
            XCTAssertFalse(firstCard.number == secondCard.number && firstCard.number == thirdCard.number && secondCard.number == thirdCard.number)
        } else {
            XCTFail("")
        }
        
    }
    
    //플레이어(2장) : 작은 숫자, 작은 숫자, 바닥영역(1장) : 큰숫자 카드를 뽑는 경우 테스트
    func testPlayerTwoLowestBottomOneHighestCardsEqual(){
        setupPlayersAndCardsForThreeCardsEqual()
        let firstSelectedCard = gameManager.selectCardFromPlayer(player: firstPlayer, isHighest: false)
        let secondSelectedCard = gameManager.selectCardFromPlayer(player: secondPlayer, isHighest: false)
        let thirdSelectedCard = gameManager.selectCardFromBottom(bottomDeck: bottomDeck, isHighest: true)
        
        
        if let firstCard = firstSelectedCard, let secondCard = secondSelectedCard, let thirdCard = thirdSelectedCard {
            XCTAssertFalse(firstCard.number == secondCard.number && firstCard.number == thirdCard.number && secondCard.number == thirdCard.number)
        } else {
            XCTFail("")
        }
        
    }
    
    
    
    func setupPlayersAndCardsForThreeCardsEqual(){
        let aCards = [LuckyCard(number: .one, type: Animal.dog),
                      LuckyCard(number: .two, type: Animal.cow),
                      LuckyCard(number: .three, type: Animal.dog),
                      LuckyCard(number: .four, type: Animal.cow),
                      LuckyCard(number: .five, type: Animal.dog),
                      LuckyCard(number: .six, type: Animal.cow),
                      LuckyCard(number: .seven, type: Animal.cat),
                      LuckyCard(number: .eight, type: Animal.cat)]

        let bCards = [LuckyCard(number: .one, type: Animal.cow),
                      LuckyCard(number: .two, type: Animal.dog),
                      LuckyCard(number: .three, type: Animal.dog),
                      LuckyCard(number: .four, type: Animal.dog),
                      LuckyCard(number: .five, type: Animal.cat),
                      LuckyCard(number: .six, type: Animal.cat),
                      LuckyCard(number: .seven, type: Animal.dog),
                      LuckyCard(number: .eight, type: Animal.cow)]

        let cCards = [LuckyCard(number: .one, type: Animal.dog),
                      LuckyCard(number: .two, type: Animal.cow),
                      LuckyCard(number: .three, type: Animal.cow),
                      LuckyCard(number: .four, type: Animal.cow),
                      LuckyCard(number: .five, type: Animal.dog),
                      LuckyCard(number: .six, type: Animal.dog),
                      LuckyCard(number: .seven, type: Animal.cat),
                      LuckyCard(number: .nine, type: Animal.cat)]
        

        firstPlayer = Player(name: "A", playerDeck: aCards)
        secondPlayer = Player(name: "B", playerDeck: bCards)
        thirdPlayer = Player(name: "C", playerDeck: cCards)
    }
    
    


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


// private func createPlayers(gameManager: GameManager) -> [Player] {

//var tripleCardDeck: [LuckyCard] = [
//    LuckyCard(number: .one, type: Animal.cat),
//    LuckyCard(number: .ten, type: Animal.cat),
//    LuckyCard(number: .one, type: Animal.cat),
//    LuckyCard(number: .four, type: Animal.dog),
//    LuckyCard(number: .five, type: Animal.dog),
//    LuckyCard(number: .one, type: Animal.dog),
//    LuckyCard(number: .seven, type: Animal.dog),
//    LuckyCard(number: .eight, type: Animal.dog)]
//
//var nonTripleCardDeck: [LuckyCard] = [
//    LuckyCard(number: .one, type: Animal.dog),
//    LuckyCard(number: .two, type: Animal.dog),
//    LuckyCard(number: .three, type: Animal.dog),
//    LuckyCard(number: .four, type: Animal.dog),
//    LuckyCard(number: .five, type: Animal.dog),
//    LuckyCard(number: .six, type: Animal.dog),
//    LuckyCard(number: .seven, type: Animal.dog),
//    LuckyCard(number: .eight, type: Animal.dog)]
//
//
//let aPlayer = Player(name: "A", playerDeck: tripleCardDeck)
//let bPlayer = Player(name: "B", playerDeck: nonTripleCardDeck)
//let cPlayer = Player(name: "C", playerDeck: nonTripleCardDeck)
//return [aPlayer, bPlayer, cPlayer]
//}
