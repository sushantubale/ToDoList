//
//  TasksModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation

struct StateViewModel: Decodable {
    var data: DataModel
}

struct DataModel: Decodable {
    var todoByPerson: [ToDoByPersonModel]
}

struct ToDoByPersonModel: Decodable {
    var name: String
    var state: String
}
