import XCTest

// UI tests for the lab sheet's testing section (Tests 1-8). They drive the real app in the
// iOS Simulator and save the screenshots required for submission.
final class MarksAppUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: - Helpers

    private func element(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    private func elementWithLabel(containing text: String) -> XCUIElement {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "label CONTAINS %@", text))
            .firstMatch
    }

    private func row(named name: String) -> XCUIElement {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "identifier == 'studentRow' AND label BEGINSWITH %@", name + ","))
            .firstMatch
    }

    private func enterStudent(name: String, mark: String) {
        let nameField = app.textFields["nameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 10))
        if !name.isEmpty {
            nameField.tap()
            nameField.typeText(name)
        }

        let markField = app.textFields["markField"]
        markField.tap()
        markField.typeText(mark)

        app.buttons["addButton"].tap()
    }

    private var totalText: String { element("totalCount").label }
    private var passedText: String { element("passedCount").label }

    private func saveScreenshot(_ name: String) {
        let screenshot = XCUIScreen.main.screenshot()

        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)

        if let directory = ProcessInfo.processInfo.environment["SCREENSHOT_DIR"] {
            let url = URL(fileURLWithPath: directory).appendingPathComponent("\(name).png")
            try? screenshot.pngRepresentation.write(to: url)
        }
    }

    private func goBack() {
        app.navigationBars["Student Details"].buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.navigationBars["SE4041 Marks"].waitForExistence(timeout: 5))
    }

    // MARK: - Tests 6 & 7 - navigation, passed count, and the submission screenshots

    func test1NavigationPassedCountAndScreenshots() {
        let students: [(name: String, mark: Int)] = [
            ("Amal", 72),
            ("Nimali", 45),
            ("Ruwan", 58),
            ("Sanduni", 90),
            ("Kasun", 38)
        ]

        for (index, student) in students.enumerated() {
            enterStudent(name: student.name, mark: "\(student.mark)")
            XCTAssertEqual(totalText, "Total: \(index + 1)")
        }

        // Test 7 - only marks of 50 or more are counted
        XCTAssertEqual(passedText, "Passed Students: 3")

        saveScreenshot("01-Student-List")

        // Add one more passing student and confirm the count updates
        enterStudent(name: "Kamal", mark: "50")
        XCTAssertEqual(passedText, "Passed Students: 4")

        // Test 6 - each row opens the correct student's details
        let all = students + [("Kamal", 50)]
        for student in all {
            let studentRow = row(named: student.name)
            XCTAssertTrue(studentRow.waitForExistence(timeout: 5), "Row for \(student.name)")
            studentRow.tap()

            XCTAssertTrue(app.navigationBars["Student Details"].waitForExistence(timeout: 5))
            XCTAssertTrue(app.staticTexts[student.name].exists)
            XCTAssertTrue(app.staticTexts["Mark: \(student.mark)"].exists)
            XCTAssertTrue(elementWithLabel(containing: student.mark >= 50 ? "PASS" : "FAIL").exists)

            if student.name == "Amal" {
                saveScreenshot("02-Student-Details")
            }
            if student.name == "Nimali" {
                saveScreenshot("03-Student-Details-Fail")
            }

            goBack()
        }
    }

    // MARK: - Tests 1 & 2 - valid and failing students, input clears after adding

    func test2ValidAndFailingStudentsAreAdded() {
        enterStudent(name: "Amal", mark: "72")
        XCTAssertEqual(totalText, "Total: 1")
        XCTAssertTrue(row(named: "Amal").label.contains("Pass"))

        // Input fields clear after a successful addition (an empty field reports its placeholder)
        XCTAssertEqual(app.textFields["nameField"].value as? String, "Student Name")
        XCTAssertEqual(app.textFields["markField"].value as? String, "Mark")

        enterStudent(name: "Nimali", mark: "45")
        XCTAssertEqual(totalText, "Total: 2")
        XCTAssertTrue(row(named: "Nimali").label.contains("Fail"))
        XCTAssertEqual(passedText, "Passed Students: 1")
    }

    // MARK: - Test 8 - boundary marks 0, 49, 50 and 100 are accepted

    func test3BoundaryMarks() {
        for mark in ["0", "49", "50", "100"] {
            enterStudent(name: "Student\(mark)", mark: mark)
        }

        XCTAssertEqual(totalText, "Total: 4")
        // 50 and 100 pass, 0 and 49 fail
        XCTAssertEqual(passedText, "Passed Students: 2")
    }

    // MARK: - Tests 3, 4, 5 and a negative mark - invalid input is not added and does not crash

    func test4InvalidInputIsRejected() {
        let invalidCases: [(name: String, mark: String)] = [
            ("", "60"),        // Test 3 - empty name
            ("Ruwan", "abc"),  // Test 4 - not a number
            ("Ruwan", "120"),  // Test 5 - above 100
            ("Ruwan", "-5")    // Test 8 - negative mark
        ]

        for invalid in invalidCases {
            app.terminate()
            app.launch()

            enterStudent(name: invalid.name, mark: invalid.mark)

            XCTAssertEqual(totalText, "Total: 0", "\(invalid) should not be added")
            XCTAssertTrue(element("errorMessage").exists, "\(invalid) should show an error")
            XCTAssertEqual(passedText, "Passed Students: 0")
        }
    }
}
