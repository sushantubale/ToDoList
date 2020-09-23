//
//  TasksModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation

public struct StateViewModel: Decodable {
    var data: DataModel
}

public struct DataModel: Decodable {
    var todoByPerson: [ToDoByPersonModel]
}

public struct ToDoByPersonModel: Decodable, Hashable {
    var name: String
    var state: String
}
