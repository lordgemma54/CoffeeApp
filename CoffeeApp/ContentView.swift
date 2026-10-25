//
//  ContentView.swift
//  CoffeeApp
//
//  Created by rahul v on 10/25/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            List {
                Group {
                    ListItem(iconName: "Cappuccino", itemName: "Cappuccino", itemPrice: 5)
                    ListItem(iconName: "Latte", itemName: "Latte", itemPrice: 4.5)
                    ListItem(iconName: "Iced", itemName: "Iced Coffee", itemPrice: 3.75)
                    ListItem(iconName: "FlatWhite", itemName: "Flat White", itemPrice: 6)
                }
                Section {
                    AddOption()
                }
            }
//            .listStyle(GroupedListStyle())
            .navigationTitle(Text("Barista"))
            .navigationBarTitleDisplayMode(.inline)
        }
        

    }
}



struct ListItem: View {
    
    var iconName : String
    var itemName : String
    var itemPrice : Double
        
    var body: some View {
        HStack {
            Image(iconName)
            Text(itemName)
            Spacer()
            Text(itemPrice, format: .currency(code: "USD"))
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
//}


// ----------------------------- PREVIEW OPTIONS -----------------------------
#Preview {
    ContentView()
        .preferredColorScheme(.light)
}


#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
