//
//  NumberPadView.swift
//  Calculator
//
//  Created by 임주민 on 2022/08/21.
//

import SwiftUI

struct NumberPadView: View {
  
  @ObservedObject var calculatorManager: CalculatorManager
  
  let positiveNumbers: [Decimal] = [1,2,3,4,5,6,7,8,9]
  
  var body: some View {
    VStack {
      positiveNumberButtons
      HStack{
        zeroButton
        pointButton
      }
    }.frame(width: 220)
  }
  
  var positiveNumberButtons: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60, maximum: 200))], spacing: 10) {
      ForEach(positiveNumbers, id: \.self) { number in
        Button {
          calculatorManager.clickNumber(number)
        } label: {
          CircleButton(content: "\(number)", color: .gray)
        }
      }
    }
  }
  
  var zeroButton: some View {
    Button {
      calculatorManager.clickNumber(0)
    } label: {
    RoundedRectangle(cornerRadius: 35)
      .frame(width: 140, height: 70)
      .foregroundColor(.gray)
      .overlay {
        Text("0")
          .font(.system(size: 40))
          .padding(.trailing, 60)
      }
    }
  }
  
  var pointButton: some View {
    Button {
      calculatorManager.addPoint()
    } label: {
      CircleButton(content: ".", color: .gray)
    }
  }
}

struct NumberPadView_Previews: PreviewProvider {
  static var previews: some View {
    let caculatorManager = CalculatorManager()
    NumberPadView(calculatorManager: caculatorManager)
  }
}