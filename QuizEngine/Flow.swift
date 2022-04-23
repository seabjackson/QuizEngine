//
//  Flow.swift
//  QuizEngine
//
//  Created by Seab Jackson on 4/19/22.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(results: [String: String ])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var results: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(results: results)
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] answer in
            guard let strongSelf = self else { return }
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                strongSelf.results[question] = answer
                if currentQuestionIndex + 1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
                } else {
                    strongSelf.router.routeTo(results: strongSelf.results)
                }
            }
        }
    }
}
 
