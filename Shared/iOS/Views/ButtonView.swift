//
//  ButtonView.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/10/20.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let imageName: String
    let backgroundColor: Color
    
    init(title: String, imageName: String, backgroundColor: Color) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        
        VStack {
            HStack(spacing: 100) {
                VStack(alignment: .leading, spacing: 40) {
                    HStack(spacing: 80) {
                        Image(systemName: imageName)
                            .padding(5)
                            .background(backgroundColor)
                            .clipShape(Circle())
                            .padding(.top, 6)
                        Text("2")
                            .font(.title)
                    }
                    Text(title)
                }
            }
        }
        .frame(width: 150, height: 100)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.red)
    }
}
