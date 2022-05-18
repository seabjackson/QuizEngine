//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Seab Jackson on 5/11/22.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutOfZeroCorrectly_scores0() {
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResults!.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResults!.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwoCorrectly_scores2() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResults!.score, 2)
    }
}

 
 
