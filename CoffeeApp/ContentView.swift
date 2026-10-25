//
//  ContentView.swift
//  CoffeeApp
//
//  Created by rahul v on 10/25/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListItem(iconName: "Coffee", itemName: "Cappuccino", itemPrice: 4.5)
        ListItem(iconName: "Coffee", itemName: "Cappuccino", itemPrice: 4.5)
        ListItem(iconName: "Coffee", itemName: "Cappuccino", itemPrice: 4.5)
        ListItem(iconName: "Coffee", itemName: "Cappuccino", itemPrice: 4.5)

    }
}

#Preview {
    ContentView()
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
            Text("$\(itemPrice)")
        }
        .padding()
    }
}
