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
        if UIDevice.current.userInterfaceIdiom == .phone {
            VStack {
                HStack(spacing: 100) {
                    VStack(alignment: .leading, spacing: 40) {
                        HStack(spacing: 80) {
                            Image(systemName: imageName)
                                .renderingMode(.original)
                                .padding(5)
                                .background(backgroundColor)
                                .clipShape(Circle())
                                .padding(.top, 6)
                            Text("2")
                                .font(.title)
                                .foregroundColor(Color.black)
                        }
                        Text(title)
                            .padding([.leading, .bottom], 5)
                            .foregroundColor(Color.black)
                    }
                }
            }
            .frame(width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.width/4))
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
            .shadow(color: Color(.blue), radius: 2, x: 2, y: 2)
            .shadow(color: Color.blue, radius: 2, x: 2, y: 2)
            .buttonStyle(BorderlessButtonStyle())
            
            
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            VStack {
                HStack(spacing: 100) {
                    VStack(alignment: .leading, spacing: 40) {
                        HStack(spacing: 80) {
                            Image(systemName: imageName)
                                .renderingMode(.original)
                                .padding(5)
                                .background(backgroundColor)
                                .clipShape(Circle())
                                .padding(.top, 6)
                            Text("2")
                                .font(.title)
                                .foregroundColor(Color.black)
                        }
                        Text(title)
                            .padding([.leading, .bottom], 5)
                            .foregroundColor(Color.black)
                    }
                }
            }
            .frame(width: (UIScreen.main.bounds.width/4), height: (UIScreen.main.bounds.width/6))
            .font(.system(.title))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
            .shadow(color: Color(.blue), radius: 2, x: 2, y: 2)
            .shadow(color: Color.blue, radius: 2, x: 2, y: 2)
            .buttonStyle(BorderlessButtonStyle())
            
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.red)
            .previewDevice(PreviewDevice(rawValue: "iPad (7th generation)"))
        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.red)
    }
}
