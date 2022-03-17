//
//  ContentView.swift
//  CalculatorApp
//
//  Created by sai krishna korukanti on 16/03/22.
//

import SwiftUI

enum CalcButton : String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case sub = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor : Color{
        switch self {
        case .add,.sub,.divide,.multiply,.equal:
            return .orange
        case .clear,.percent,.negative:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}
enum Operation{
    case add, subtract, multiply, divide,none
    
}
struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation : Operation = .none
    let buttons : [[CalcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.sub],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal,]]
    var body: some View {
        ZStack{
          
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 72))
                    .foregroundColor(.white)
                }
          .padding()
            ForEach(buttons, id : \.self){row in
                HStack(spacing : 12) {
                    ForEach(row, id: \.self){item in
                        Button(action: {
                            self.didTap(button: item)
                        },label: {
                            Text(item.rawValue)
                                .frame(width: self.buttonWidth(item :item), height: self.buttonHeight())
                                .font(.system(size: 32))
                                .background(item.buttonColor)
                                .foregroundColor(Color.white)
                                .cornerRadius(self.buttonWidth(item: item)/2)
                        })
                    }
                }
            }
            }.padding(.bottom,3)
            
        }
    }
    func buttonWidth(item : CalcButton) ->CGFloat{
        if item == .zero{
            return ((UIScreen.main.bounds.width - (5*12))/4)*2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    func buttonHeight() ->CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    func didTap(button : CalcButton){
        
        switch button{
        case .add:
            self.currentOperation = .add
            self.runningNumber = Int(self.value) ?? 0
            self.value = "0"
            
        case .divide :
            self.currentOperation = .divide
            self.runningNumber = Int(self.value) ?? 0
            self.value = "0"
        case .sub :
            self.currentOperation = .subtract
            self.runningNumber = Int(self.value) ?? 0
            self.value = "0"
        case .multiply :
            self.currentOperation = .multiply
            self.runningNumber = Int(self.value) ?? 0
            self.value = "0"
        case .equal  :
            let runningValue = self.runningNumber
            let currentValue = Int(self.value) ?? 0
            switch self.currentOperation{
            case .add : self.value = "\(runningValue+currentValue)"
            case .subtract : self.value = "\(runningValue-currentValue)"
            case .multiply : self.value = "\(runningValue*currentValue)"
            case .divide : self.value = "\(runningValue/currentValue)"
            case .none : break
         
            }
            
        case .clear:
            self.value = "0"
        case .decimal,.negative,.percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
       
    }
   
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        }
    }
}
