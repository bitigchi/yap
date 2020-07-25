// Program.swift
// Author: Emir Sarı
// Copyright © 2020 Emir Sarı. All rights reserved.
// See LICENSE for details

import Foundation

final class Program {
    lazy var now = Calendar.current.dateComponents(in: .current, from: Date())
    lazy var tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
    lazy var nextWeek = DateComponents(year: now.year, month: now.month, day: now.day! + 7)
    lazy var nextMonth = DateComponents(year: now.year, month: now.month! + 1, day: now.day)
    lazy var nextYear = DateComponents(year: now.year! + 1, month: now.month, day: now.day)
    lazy var whoKnowsWhen = DateComponents(year: now.year! + 10, month: now.month, day: now.day)
    lazy var todayDate = Calendar.current.date(from: now)!
    lazy var tomorrowDate = Calendar.current.date(from: tomorrow)!
    lazy var nextWeekDate = Calendar.current.date(from: nextWeek)!
    lazy var nextMonthDate = Calendar.current.date(from: nextMonth)!
    lazy var nextYearDate = Calendar.current.date(from: nextYear)!
    lazy var whoKnowsWhenDate = Calendar.current.date(from: whoKnowsWhen)!

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
    
    let bundle = program.localizationBundle(
        forLanguage: Locale.current.languageCode ?? "en")
    
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
        var dateLine = ""
        var finalDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale.current
        
        if date == "today" {
            dateLine = dateFormatter.string(from: todayDate)
        } else if date == "tomorrow" {
            dateLine = dateFormatter.string(from: tomorrowDate)
        } else if date == "nextweek" {
            dateLine = dateFormatter.string(from: nextWeekDate)
        } else if date == "nextmonth" {
            dateLine = dateFormatter.string(from: nextMonthDate)
        } else if date == "nextyear" {
            dateLine = dateFormatter.string(from: nextYearDate)
        } else {
            dateLine = dateFormatter.string(from: whoKnowsWhenDate)
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
                    let string = formatter.string(from: dueDate)
                    consoleIO.writeMessage(
                        String(format: NSLocalizedString(
                                "Due date set to: %@",
                                bundle: bundle ?? .module,
                                comment: "Info text"),
                               string))
                    consoleIO.writeMessage(
                        String(format: NSLocalizedString(
                                "For: %@",
                                bundle: bundle ?? .module,
                                comment: "Info text"),
                               todo.name))
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
                            consoleIO.writeMessage(
                                String(format: NSLocalizedString(
                                        "Pending: %@",
                                        bundle: bundle ?? .module,
                                        comment: "Info text"),
                                       todo.name))
                        }
                    } else {
                        todoList[index].complete = true
                        writeTodoList(todoList)
                        if !silent {
                            consoleIO.writeMessage(
                                String(format: NSLocalizedString(
                                        "Complete: %@",
                                        bundle: bundle ?? .module,
                                        comment: "Info text"),
                                       todo.name))
                        }
                    }
                }
            }
        }
        consoleIO.writeMessage(String(format: NSLocalizedString(
                                        "Changed state: %@",
                                        bundle: bundle ?? .module,
                                        comment: "Info text"),
                                      numbers.description))
    }
    
    func list(complete: Bool, _ noDate: Bool) {
        for (index, todo) in todoList.enumerated() {
            func printItem() {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let nextYearDate = Calendar.current.date(from: nextYear)!
                var dueDate = ""
                
                if todo.dueDate > nextYearDate {
                    dueDate = NSLocalizedString("no date",
                                                bundle: bundle ?? .module,
                                                comment: "No date entered")
                } else {
                    dueDate = formatter.string(from: todo.dueDate)
                }

                let item = "\(index + 1). " + "\(todo.name)"
                let itemWDate = "\(index + 1)." +
                    " <\(dueDate)> " +
                    "\(todo.name)"
                
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
                consoleIO.writeMessage(
                    String(format: NSLocalizedString(
                            "Purged: %@",
                            bundle: bundle ?? .module,
                            comment: "Info text"),
                           todo.name))
            }
        }
        writeTodoList(todoList)
        consoleIO.writeMessage(NSLocalizedString(
                                "All items have been purged.",
                                bundle: bundle ?? .module,
                                comment: "Info text"))
    }
    
    func purgeCompleted(_ silent: Bool) {
        for todo in todoList {
            if let index = todoList.firstIndex(
                where: {_ in todo.complete == true}) {
                todoList.remove(at: index)
                writeTodoList(todoList)
                if !silent {
                    consoleIO.writeMessage(
                        String(format: NSLocalizedString(
                                "Deleted: %@",
                                bundle: bundle ?? .module,
                                comment: "Info text"),
                               todo.name))
                }
            }
        }
        consoleIO.writeMessage(NSLocalizedString(
                                "All completed items have been purged.",
                                bundle: bundle ?? .module,
                                comment: "Confirmation message"))
    }
    
    func removeItem(_ number: Int, _ silent: Bool) {
        var removedItemArray = [TodoItem]()
        removedItemArray.append(todoList[number - 1])
        
        todoList.remove(at: number - 1)
        writeTodoList(todoList)
        if !silent {
            consoleIO.writeMessage(
                String(format: NSLocalizedString(
                        "Removed: %@",
                        bundle: bundle ?? .module,
                        comment: "Info text"),
                       removedItemArray[0].name))
        }
        removedItemArray.removeAll()
    }
    
    func localizationBundle(forLanguage language: String) -> Bundle? {
         if let path = Bundle.module.path(forResource: language,
                                          ofType: "lproj") {
             return Bundle(path: path)
         } else {
             return nil
         }
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
