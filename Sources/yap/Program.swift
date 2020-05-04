// Program.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import Foundation

final class Program {
    let fileURL = try! FileManager.default
        .url(for: .applicationSupportDirectory,
             in: .userDomainMask,
             appropriateFor: nil,
             create: true)
        .appendingPathComponent("yap.json")

    var todoList: [TodoItem] = {
        do {
            let fileURL = try! FileManager.default
                .url(for: .applicationSupportDirectory,
                     in: .userDomainMask,
                     appropriateFor: nil,
                     create: true)
                .appendingPathComponent("yap.json")
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([TodoItem].self, from: data)
            return items
        } catch {
            return []
        }
    }()
    
    
    // MARK: Operation Functions
    func writeTodoList(_ todoList: [TodoItem]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            try encoder.encode(todoList).write(to: fileURL)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func markAsComplete(_ numbers: [Int], _ pending: Bool, _ silent: Bool) {
        for (index, todo) in todoList.enumerated() {
            for number in numbers {
                if number == index + 1 {
                    if pending {
                        todoList[index].complete = false
                        todoList[index].modifyDate = Date()
                        writeTodoList(todoList)
                        if !silent {
                            consoleIO.writeMessage(NSLocalizedString(
                                "Pending: \(todo.name)",
                                comment: "Confirmation message"))
                        }
                    } else {
                        todoList[index].complete = true
                        todoList[index].modifyDate = Date()
                        writeTodoList(todoList)
                        if !silent {
                            consoleIO.writeMessage(NSLocalizedString(
                                "Complete: \(todo.name)",
                                comment: "Confirmation message"))
                        }
                    }
                }
            }
        }
        consoleIO.writeMessage(NSLocalizedString(
            "Changed state: \(numbers.description)",
            comment: "Confirmation message"))
    }
    
    func list(complete: Bool, _ date: Bool) {
        for (index, todo) in todoList.enumerated() {
            if todoList[index].complete == complete {
                if !date {
                    consoleIO.writeMessage(
                        "\(index + 1)" + " - " + "\(todo.name)")
                } else {
                    consoleIO.writeMessage(
                        "\(index + 1)" + " -" + "\(todo.addDate)" + "- "
                        + "\(todo.name)")
                }
            }
        }
    }
    
    func purgeAll(_ silent: Bool) {
        for todo in todoList {
            todoList.removeAll()
            if !silent {
                consoleIO.writeMessage(NSLocalizedString(
                    "Deleted: \(todo.name)", comment: "Deleted item"))
            }
        }
        writeTodoList(todoList)
        consoleIO.writeMessage(NSLocalizedString(
                "All items have been purged.",
                comment: "Confirmation message"))
    }
    
    func purgeCompleted(_ silent: Bool) {
        for todo in todoList {
            if let index = todoList.firstIndex(
                where: {_ in todo.complete == true}) {
                todoList.remove(at: index)
                writeTodoList(todoList)
                if !silent {
                    consoleIO.writeMessage(NSLocalizedString(
                    "Deleted: \(todo.name)", comment: "Deleted item"))
                }
            }
        }
        consoleIO.writeMessage(NSLocalizedString(
                "All completed items have been purged.",
                comment: "Confirmation message"))
    }
    
    func removeItem(_ number: Int, _ silent: Bool) {
        todoList.remove(at: number - 1)
        writeTodoList(todoList)
        if !silent {
            consoleIO.writeMessage(NSLocalizedString(
                "Removed: \(todoList[number - 1].name)",
                comment: "Confirmation message"))
        }
    }
    
    
    // MARK: Validation Functions
    func alreadyInList(_ todoItem: TodoItem) throws {
        guard todoList.contains(
            where: { $0.name == (todoItem.name) }) == false else {
                throw ValidationError.alreadyInList
        }
    }
    
    func alreadyCompleted(_ numbers: [Int]) throws {
        for number in numbers {
            guard todoList[number - 1].complete == false else {
                throw ValidationError.alreadyCompleted
            }
        }
    }
    
    func emptyTodo(_ todoItem: TodoItem) throws {
        guard todoItem.name != "" else {
            throw ValidationError.emptyTodo
        }
    }
    
    func verifyFileExists() throws {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw ValidationError.noFile
        }
    }
    
    func checkEmptyList() throws {
        guard todoList.isEmpty == false else {
            throw ValidationError.emptyList
        }
    }
    
    func checkEmptyRemainingList() throws {
        guard todoList.contains(where: {$0.complete == false}) else {
            throw ValidationError.emptyList
        }
    }
    
    func checkEmptyCompleteList() throws {
        guard todoList.contains(where: {$0.complete == true}) else {
            throw ValidationError.noCompletedItem
        }
    }
   
    func notValidItemNumber(_ number: Int) throws {
        guard number <= todoList.count || number == 0 else {
            throw ValidationError.notValid
        }
    }    
}
