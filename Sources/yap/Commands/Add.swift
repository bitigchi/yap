// Add.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Add: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: NSLocalizedString(
            "add", comment: "Add command"),
        abstract: NSLocalizedString(
            "Add item to the list.", comment: "Add command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
            "To-do text.", comment: "Help text")))
    private var item: String?
    
    
    func run() throws {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let addDate = formatter.string(from: date)
        
        let todoItem = TodoItem(
            name: item ?? "\(readLine() ?? "")",
            complete: false,
            addDate: addDate,
            modifyDate: Date())
        
        try program.alreadyInList(todoItem)
        try program.emptyTodo(todoItem)
        
        program.todoList.append(todoItem)
        program.writeTodoList(program.todoList)
        consoleIO.writeMessage("To-do added successfully!")
    }
}
