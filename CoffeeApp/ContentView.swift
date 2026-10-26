//
//  ContentView.swift
//  CoffeeApp
//
//  Created by rahul v on 10/25/26.
//

import SwiftUI

struct ContentView: View {
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
                
                Section {
                    AddOption()
                }
                Section {
                    Total(items: $coffeeMenu)
                }
                Section {
                    ConfirmOrder()
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
    
//    var flavor : String
}


struct ListItem: View {
    @Binding var item: CoffeeItem
        
    var body: some View {
        HStack {
            Image(item.iconName)
            Text(item.itemName)
            Spacer()
            Text(item.itemPrice, format: .currency(code: "USD")).padding(.trailing, 8)
            
            HStack(spacing: 8) {
                
                Stepper("", value: $item.quantity, in: 0...99).labelsHidden().fixedSize()
                Text("\(item.quantity)").frame(minWidth: 20, alignment: .leading)
            }
            
        }
        .padding()
    }
}



struct AddOption: View {
    @State var flag : Bool = false
    @State var option : String = "Mocha"
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



//struct AddTip: View {
//    @State var flag : Bool = false
//    @State var tip : Int = 0
//    var tips : [Int] = [10, 15, 18, 20]
//    
//    var body : some View {
//        VStack {
//            Toggle("Add a tip", isOn: $flag.animation())
//            if flag {
//                Picker("Tip amount", selection: $tip) {
//                    ForEach(tips, id: \.self) { option in
//                        Text("%\(option)")
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//            }
//        }
//    }
//}


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
    
    var body : some View {
        Button("Confirm Order") {
            present.toggle()
        }
        .sheet(isPresented: $present, content: {
            SecondView(present: $present)
        })
    }
}


struct SecondView: View {
    @Binding var present : Bool
    
    var body : some View {
        VStack {
            Text("Order Submitted")
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
