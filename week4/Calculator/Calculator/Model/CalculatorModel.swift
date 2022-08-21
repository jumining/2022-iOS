//
//  Calculator.swift
//  Calculator
//
//  Created by 임주민 on 2022/08/21.
//

import Foundation

struct Caculator {
  
  var operation: ArithmeticOperation?
  var state: InputState = .newPreviousNumber
  private(set) var showingText: Double
  private(set) var previousNumber: Double? { didSet { showingText = previousNumber ?? 0 } }
  private(set) var nextNumber: Double? { didSet { showingText = nextNumber ?? 0 } }
  private(set) var result: Double {
    didSet {
      showingText = result
      previousNumber = result
    }
  }
  
  mutating func clickNumber(_ number: Double) {
    switch state {
    case .newPreviousNumber:
      previousNumber = number
      state = .ongoingPreviousNumber
    case .newNextNumber:
      nextNumber = number
      state = .ongoingNextNumber
    case .ongoingPreviousNumber, .ongoingNextNumber:
      joinNumbers(nextElement: number)
    }
  }
  
  mutating func caculate() {
    guard let priorNumber = previousNumber else { return }
    guard let laterNumber = nextNumber else { return }
    guard let operation = operation else { return }
    switch operation {
    case .multiply:
      result = priorNumber * laterNumber
    case .divide:
      result = priorNumber / laterNumber
    case .minus:
      result = priorNumber - laterNumber
    case .plus:
      result = priorNumber + laterNumber
    }
  }
  
  mutating func joinNumbers(nextElement: Double) {
    if state == .ongoingPreviousNumber {
      guard let previousElement = previousNumber else { return }
      let joinedNumber = String(previousElement.clean) + String(nextElement.clean)
      previousNumber = Double(joinedNumber)
    } else if state == .ongoingNextNumber {
      guard let previousElement = nextNumber else { return }
      let joinedNumber = String(previousElement.clean) + String(nextElement.clean)
      nextNumber = Double(joinedNumber)
    }
  }
  
  mutating func changeSign() {
    if let priorNumber = previousNumber {
      previousNumber = -priorNumber
    }
  }
  
  mutating func percent() {
    result = showingText / 100
  }
  
  func addPoint() { }
}
