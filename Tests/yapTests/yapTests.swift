import XCTest
@testable import yap

final class yapTests: XCTestCase {
    var todo1: TodoItem!
    var todo2: TodoItem!
    var todo3: TodoItem!
    let todoText1 = "لزم الآكل الموز"
    let todoText2 = "Иди нахер"
    let todoText3 = "吃菜"

    override func setUp() {
        super.setUp()
        let dueDate1 = program.dateParser("nextmonth")
        let dueDate2 = program.dateParser("nextyear")
        let dueDate3 = Date().addingTimeInterval(86400)
        todo1 = TodoItem(name: todoText1, complete: false, dueDate: dueDate1)
        todo2 = TodoItem(name: todoText2, complete: false, dueDate: dueDate2)
        todo3 = TodoItem(name: todoText3, complete: false, dueDate: dueDate3)
    }
    
    override func tearDown() {
        super.tearDown()
        program.todoList.removeAll()
    }

    func addItemTest() {
        program.todoList.append(todo1)
        program.todoList.append(todo2)
        program.todoList.append(todo3)
        program.writeTodoList(program.todoList)
        consoleIO.writeMessage("To-do added successfully!")
        XCTAssertEqual(program.todoList, [todo1, todo2, todo3])
        XCTAssertTrue(program.todoList.count == 3)
    }
    
    static var allTests = [
        ("addItemTest", addItemTest),
    ]
}
