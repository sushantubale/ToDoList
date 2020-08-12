//
//  ListViewWithHeader.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct ListViewWithHeader: View {
    
    let listData: [ListData]
    init(listData: [ListData]) {
        self.listData = listData
    }
    
    var body: some View {
        List {
            ForEach(listData) { listHeader in
                Section(header: HStack {
                    Text(listHeader.headerTitle)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading)
                }
                .background(Color.clear)
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                ) {
                    ForEach(0..<listHeader.rows.count) { item in
                        HStack {
                            NavigationLink(destination: Text("Detail View")) {
                                Image(systemName: "list.dash")
                                    .renderingMode(.template)
                                    .foregroundColor(.blue)
                                Text(listHeader.rows[item])
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ListViewWithHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListViewWithHeader(listData: [
            ListData(headerTitle: "Numbers", rows: ["1","2","3"]),
            ListData(headerTitle: "Letters", rows: ["A","B","C"]),
            ListData(headerTitle: "Symbols", rows: ["€","%","&"])
        ])
    }
}

struct ListData: Identifiable {
    var id = UUID()
    var headerTitle: String
    var rows: [String]
}
