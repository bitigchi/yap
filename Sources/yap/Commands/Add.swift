// Add.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import ArgumentParser
import Foundation

struct Add: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "add",
        abstract: NSLocalizedString(
            "Add item to the list.",
            bundle:program.bundle ?? .module,
            comment: "Add command description"),
        shouldDisplay: true)
    
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "To-do text.",
                                    bundle:program.bundle ?? .module,
                                    comment: "Help text")))
    private var item: String?
    
    @Argument(help: ArgumentHelp(NSLocalizedString(
                                    "Due date.",
                                    bundle:program.bundle ?? .module,
                                    comment: "Help text")))
     private var dueDate: String?
    
    
    func run() throws {
        let todoItem = TodoItem(
            name: item ?? "\(readLine() ?? "")",
            complete: false,
            dueDate: program.dateParser(dueDate ?? ""))
        
        try program.alreadyInList(todoItem)
        try program.emptyTodo(todoItem)
        
        program.todoList.append(todoItem)
        program.writeTodoList(program.todoList)
        consoleIO.writeMessage(NSLocalizedString(
                                "To-do added successfully!",
                                bundle:program.bundle ?? .module,
                                comment: "Info text"))
    }
}
