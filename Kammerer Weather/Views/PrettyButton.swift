//
//  PrettyButton.swift
//  Kammerer Weather
//
//  Created by Lichtenstein, Edan on 4/14/24.
//

import SwiftUI

struct PrettyButton: View {
    
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Get Weather")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

//#Preview {
//    PrettyButton(action: () -> Void)
//}


struct PrettyButton_Previews: PreviewProvider {
    static var previews: some View {
        PrettyButton {
            print("Button pressed!")
        }
    }
}
