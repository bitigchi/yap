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
            decoder.dateDecodingStrategy = .millisecondsSince1970
            let items = try decoder.decode([TodoItem].self, from: data)
            return items
        } catch {
            return []
        }
    }()
    
    
    // MARK: Operation Methods
    func writeTodoList(_ todoList: [TodoItem]) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .millisecondsSince1970
            try encoder.encode(todoList).write(to: fileURL)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    func dateParser(_ date: String) -> Date {
        var finalDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale.current
                
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(
            year: now.year, month: now.month, day: now.day! + 1)
        let nextWeek = DateComponents(
            year: now.year, month: now.month, day: now.day! + 7)
        let nextMonth = DateComponents(
            year: now.year, month: now.month! + 1, day: now.day)
        let nextYear = DateComponents(
            year: now.year! + 1, month: now.month, day: now.day)
        
        var dateLine = ""
        
        if date == "tomorrow" {
            let tomorrowDate = Calendar.current.date(from: tomorrow)!
            dateLine = dateFormatter.string(from: tomorrowDate)
        } else if date == "nextweek" {
            let nextWeekDate = Calendar.current.date(from: nextWeek)!
            dateLine = dateFormatter.string(from: nextWeekDate)
        } else if date == "nextmonth" {
            let nextMonthDate = Calendar.current.date(from: nextMonth)!
            dateLine = dateFormatter.string(from: nextMonthDate)
        } else if date == "nextyear" {
            let nextYearDate = Calendar.current.date(from: nextYear)!
            dateLine = dateFormatter.string(from: nextYearDate)
        } else {
            dateLine = date
        }
        
         if let dateFormat = dateFormatter.date(from: dateLine) {
             finalDate = dateFormat
         }
         return finalDate
     }
    
    func markDue(_ number: Int, _ dateStr: String, _ silent: Bool) {
        for (index, todo) in todoList.enumerated() {
            if number == index + 1 {
                let dueDate = dateParser(dateStr)
                todoList[index].dueDate = dueDate
                writeTodoList(todoList)
                if !silent {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    consoleIO.writeMessage(NSLocalizedString(
                        """
                        Due date set to \(formatter.string(
                        from: dueDate)),
                        for: \(todo.name)
                        """,
                        comment: "Confirmation message"))
                }
            }
        }
    }
    
    func markAsComplete(_ numbers: [Int], _ pending: Bool, _ silent: Bool) {
        for (index, todo) in todoList.enumerated() {
            for number in numbers {
                if number == index + 1 {
                    if pending {
                        todoList[index].complete = false
                        writeTodoList(todoList)
                        if !silent {
                            consoleIO.writeMessage(NSLocalizedString(
                                "Pending: \(todo.name)",
                                comment: "Confirmation message"))
                        }
                    } else {
                        todoList[index].complete = true
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
    
    func list(complete: Bool, _ noDate: Bool) {
        for (index, todo) in todoList.enumerated() {
            
            func printItem() {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let dueDate = formatter.string(from: todo.dueDate)
                let item = "\(index + 1)" + " - " + "\(todo.name)"
                let itemWDate = "\(index + 1)" + " -" + "\(dueDate)" + "- " + "\(todo.name)"
                
                if noDate {
                    consoleIO.writeMessage(item)
                } else {
                    consoleIO.writeMessage(itemWDate)
                }
            }
            
            if todoList[index].complete == complete {
                printItem()
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
        var removedItemArray = [TodoItem]()
        removedItemArray.append(todoList[number - 1])
        
        todoList.remove(at: number - 1)
        writeTodoList(todoList)
        if !silent {
            consoleIO.writeMessage(NSLocalizedString(
                "Removed: \(removedItemArray[0].name)",
                comment: "Confirmation message"))
        }
        removedItemArray.removeAll()
    }
    
    
    // MARK: Validation Methods
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
