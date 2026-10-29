//
//  ContentView.swift
//  CoffeeApp
//
//  Created by rahul v on 10/25/26.
//

import SwiftUI

struct ContentView: View {

    
    @State var addedTip : Bool = false
    @State var option : Int = 10
    @State var gradTotal : Double = 0

    @State var coffeeMenu: [CoffeeItem] = [
        CoffeeItem(iconName: "Cappuccino", itemName: "Cappuccino", itemPrice: 5.0, quantity: 0),
        CoffeeItem(iconName: "Latte", itemName: "Latte", itemPrice: 4.5, quantity: 0),
        CoffeeItem(iconName: "Iced", itemName: "Iced Coffee", itemPrice: 3.75, quantity: 0),
        CoffeeItem(iconName: "FlatWhite", itemName: "Flat White", itemPrice: 6.0, quantity: 0)
    ]
    
    var grandTotal : Double {
        var currentTotal: Double = 0.0
        for item in coffeeMenu{
            currentTotal += Double(item.quantity) * item.itemPrice
        }
        if addedTip {
            currentTotal += currentTotal * (Double(option) / 100)
        }
        return currentTotal
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<coffeeMenu.count, id: \.self) { index in
                    ListItem(item: $coffeeMenu[index])
                }
                AddTip(addedTip: $addedTip, option: $option)
                Section {
                    Total(grandTotal: grandTotal)
                    ConfirmOrder(items: $coffeeMenu, addedTip: $addedTip, option: $option, grandTotal: grandTotal)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("Barista!"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct CoffeeItem {
    var iconName : String
    var itemName : String
    var itemPrice : Double
    var quantity : Int
}


struct ListItem: View {
    @Binding var item: CoffeeItem
        
    var body: some View {
        VStack {
            HStack {
                Image(item.iconName)
                Text(item.itemName)
                Spacer()
                Text(item.itemPrice, format: .currency(code: "USD")).padding(.trailing, 2)
                
                HStack(spacing: 3) {
                    Stepper("", value: $item.quantity, in: 0...99).labelsHidden().fixedSize()
                    Text("\(item.quantity)").frame(minWidth: 18, alignment: .leading)
                }
                
            }
            .padding()
        }
    }
}


struct AddTip: View {
    @Binding var addedTip : Bool
    @Binding var option : Int
    
    var options : [Int] = [10, 15, 18, 20]
    
    var body : some View {
        VStack {
            Toggle("Add a Tip", isOn: $addedTip.animation())
            if addedTip {
                Picker("%", selection: $option) {
                    ForEach(options, id: \.self) { option in
                        Text("\(option)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
        }
    }
}



struct Total: View {
    let grandTotal : Double
    
    var body: some View {
        HStack {
            Text("Total")
            Spacer()
            Text(grandTotal, format: .currency(code: "USD")).bold()
        }
    }
}


struct ConfirmOrder: View {
    @State var present : Bool = false
    
    @Binding var items : [CoffeeItem]
    @Binding var addedTip : Bool
    @Binding var option : Int
    
    let grandTotal : Double
    
    var body : some View {
        VStack {
            Button("Confirm Order") {
                present.toggle()
            }
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $present) {
                SecondView(present: $present, items: $items, addedTip: $addedTip, option: $option, grandTotal: grandTotal)
            }
        }
    }
}



struct SecondView: View {
    @Binding var present : Bool
    
    @Binding var items : [CoffeeItem]
    @Binding var addedTip : Bool
    @Binding var option : Int
    
    let grandTotal : Double
    
    var body : some View {
        List {
            VStack {
                Text("Your Order").bold()
                
                ForEach(items, id: \.itemName) {item in
                    if item.quantity > 0 {
                        HStack {
                            Text(item.itemName)
                                .italic()
                                .foregroundColor(.secondary)
                            Text("(\(item.quantity))")
                            Spacer()
                            Text(item.itemPrice, format: .currency(code: "USD"))
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                HStack{
                    Text("Added Tip: ")
                        .italic()
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("% \(option)")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                HStack {
                    Text("Total")
                        .italic()
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(grandTotal, format: .currency(code: "USD")).bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                VStack {
                    Button("Return") {
                        present.toggle()
                    }
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }.listStyle(GroupedListStyle())
                
        }
    }
}


// ----------------------------- PREVIEW OPTIONS 
#Preview {
    ContentView()
        .preferredColorScheme(.light)
}


#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
