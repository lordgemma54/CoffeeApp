//
//  ContentView.swift
//  CoffeeApp
//
//  Created by rahul v on 10/25/26.
//

import SwiftUI

struct ContentView: View {
//    @State var flag : Bool = false
//    @State var option : String = "Mocha"
    
    @State var wantsFlavor : Bool = false
    @State var chosenFlavor : String = "Mocha"


    @State var coffeeMenu: [CoffeeItem] = [
        CoffeeItem(iconName: "Cappuccino", itemName: "Cappuccino", itemPrice: 5.0, quantity: 0),
        CoffeeItem(iconName: "Latte", itemName: "Latte", itemPrice: 4.5, quantity: 0),
        CoffeeItem(iconName: "Iced", itemName: "Iced Coffee", itemPrice: 3.75, quantity: 0),
        CoffeeItem(iconName: "FlatWhite", itemName: "Flat White", itemPrice: 6.0, quantity: 0)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<coffeeMenu.count, id: \.self) { index in
                    ListItem(item: $coffeeMenu[index])
                }
                AddOption(flag: $wantsFlavor, option: $chosenFlavor)
                Section {
                    Total(items: $coffeeMenu)
                    ConfirmOrder(items: $coffeeMenu, addFlavor: $wantsFlavor, chosenFlavor: $chosenFlavor)
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



struct AddOption: View {
    @Binding var flag : Bool
    @Binding var option : String
    
    var options : [String] = ["Mocha", "Vanilla", "Caramel"]
    
    var body : some View {
        VStack {
            Toggle("Add a flavor", isOn: $flag.animation())
            if flag {
                Picker("Flavor options", selection: $option) {
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
    @Binding var items: [CoffeeItem]
    
//   Computed property for keeping track of the total
    var grandTotal : Double {
        var currentTotal: Double = 0.0
        for item in items {
            currentTotal += Double(item.quantity) * item.itemPrice
        }
        return currentTotal
    }
    
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
    @Binding var addFlavor : Bool
    @Binding var chosenFlavor : String
    
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
                SecondView(present: $present, items: $items, addFlavor: $addFlavor, chosenFlavor: $chosenFlavor)
            }
                
            }

            }

        }



struct SecondView: View {
    @Binding var present : Bool
    
    @Binding var items : [CoffeeItem]
    @Binding var addFlavor : Bool
    @Binding var chosenFlavor : String
    
    var body : some View {
            VStack {
                Text("Your Order").bold()
                
                ForEach(items, id: \.itemName) {item in
                    if item.quantity > 0 {
                        Text("Item: \(item.itemName)")
                            .italic()
                            .foregroundColor(.secondary)
                        Text("Added Flavor: \(chosenFlavor)")
                            .italic()
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Button("Return") {
                    present.toggle()
                }
            }
    }
}


// ----------------------------- PREVIEW OPTIONS -----------------------------
#Preview {
    ContentView()
        .preferredColorScheme(.light)
}


#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
