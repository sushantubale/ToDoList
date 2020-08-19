//
//  CollectionViewCell.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/18/20.
//

import SwiftUI

struct CollectionViewCell: View {
    var column: Int?
    var row: Int?
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    let width = (UIScreen.main.bounds.width/3)-20
    
    var body: some View {
        ZStack {
                NavigationLink(destination: Text("Detail View")) {
                    ButtonView(title: "Inbox", imageName: Constants.ImageNames.trayArrowDown, backgroundColor: .red)
                        .frame(width: width, height: width, alignment: .center)
                        .padding(.all)
                }
        }
    }
}

struct CollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCell(row: 2, column: 2)
            .previewDevice(PreviewDevice(rawValue: "iPad (7th generation)"))

    }
}
