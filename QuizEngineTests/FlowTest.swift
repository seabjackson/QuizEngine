//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Seab Jackson on 4/19/22.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routesToFirstQuestion_2() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestion_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestion_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
        XCTAssertEqual(router.routedResults?.answers, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRoutesToResults() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResults)
    }
     
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResults() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults?.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"]) { _ in 10 }
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helpers
    func makeSUT(questions: [String], scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
    
}
