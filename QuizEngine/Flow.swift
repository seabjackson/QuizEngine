//
//  Flow.swift
//  QuizEngine
//
//  Created by Seab Jackson on 4/19/22.
//

import Foundation

protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable
    typealias AnswerCallback = (Answer) -> Void
    
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(results: [Question: Answer])
}

class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var results: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(results: results)
        }
    }
    
    private func nextCallback(from question: Question) -> R.AnswerCallback {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            results[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(results: results)
            }
        }
    }
}
 
