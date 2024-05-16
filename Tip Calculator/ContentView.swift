//
//  ContentView.swift
//  Tip Calculator
//
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = ""
    @State private var tipPercentageIndex = 0
    @State private var customTipPercentage = ""
    @State private var numberOfPeople = ""
    
    let tipPercentages = [15, 18, 20]
    
    var selectedTipPercentage: Double {
        if let customTip = Double(customTipPercentage), customTip > 0 {
            return customTip
        } else {
            return Double(tipPercentages[tipPercentageIndex])
        }
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = selectedTipPercentage
        let orderAmount = Double(billAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = selectedTipPercentage
        let orderAmount = Double(billAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Bill Amount")
                        .font(.headline)
                    
                    TextField("Enter bill amount", text: $billAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray4))
                        .cornerRadius(10)
                    
                    Text("Tip Percentage")
                        .font(.headline)
                    
                    Picker("Tip Percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    TextField("Enter custom tip percentage", text: $customTipPercentage)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray4))
                        .cornerRadius(10)
                    
                    Text("Number of People")
                        .font(.headline)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray4))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total Amount")
                        .font(.headline)
                    
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Amount per Person")
                        .font(.headline)
                    
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(Color.orange.edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
