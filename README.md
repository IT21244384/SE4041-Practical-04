# SE4041 – Mobile Application Design & Development  
## Practical 04 – Building Your First iOS App with SwiftUI

**Module:** SE4041 – Mobile Application Design & Development  
**Development Environment:** Xcode  
**Framework:** SwiftUI  
**Language:** Swift

---

## 1. Practical Overview

In the previous practicals, you learned the Swift language concepts required for iOS application development.

You have already worked with:

- Variables and constants
- Data types and optionals
- Arrays, sets, and dictionaries
- Conditions and loops
- Functions and closures
- Enumerations
- Structures and classes
- Stored and computed properties

In this practical, you will bring those concepts together and build an **actual iOS application using SwiftUI**.

You will create and run an Xcode project, design interfaces using SwiftUI views and stacks, manage changing values using `@State`, accept user input, display data using `List`, and move between screens using navigation.

Lecture 05 specifically connects these ideas to concepts you already know: a SwiftUI screen is a struct, `body` is a computed property, `VStack {}` uses a trailing closure, and lists can be driven by arrays.

---

## 2. Learning Objectives

By the end of this practical, you should be able to:

1. Create an iOS application project using Xcode.
2. Run an application using the iOS Simulator.
3. Explain the basic structure of a SwiftUI application.
4. Create SwiftUI interfaces using `Text`, `Image`, stacks, `Spacer`, and modifiers.
5. Use `@State` to manage values that change on screen.
6. Accept user input using `TextField`.
7. Respond to user interaction using `Button`.
8. Display collections using `List`.
9. Create model structures that conform to `Identifiable`.
10. Navigate between screens using `NavigationStack` and `NavigationLink`.
11. Extract reusable interface components into subviews.
12. Build and test a simple multi-screen iOS application.

These match the learning outcomes of Lecture 05.

---

## 3. Exercise 0 – GitHub and Project Setup

Before starting:

1. Log in to your GitHub account.
2. Accept the GitHub Classroom assignment provided by your instructor.
3. Clone or open the repository on the Mac.
4. Open **Xcode**.

Create a new project:

**File → New → Project**

Then select:

**iOS → App**

Use the following settings:

```text
Product Name: MarksApp
Interface: SwiftUI
Language: Swift
Storage: None
```

For the Organization Identifier, you may use:

```text
lk.ac.sliit
```

Choose the folder inside your GitHub repository.

Xcode creates the main application files automatically. The lecture identifies the app entry-point file, `ContentView.swift`, asset catalogue, previews, and project settings as the main parts students should recognize.

---

## 4. Run the Starter Application

Before changing any code:

1. Select an iPhone Simulator from the Xcode toolbar.
2. Press **Run**.
3. Wait for the Simulator to open.
4. Confirm that the default application runs.

Useful shortcuts:

```text
Command + R    Run
Command + .    Stop
```

The Simulator behaves similarly to a real iPhone for normal interface testing.

---

## 5. Understanding the App Entry Point

Open the application file similar to:

```text
MarksAppApp.swift
```

You should see code similar to:

```swift
import SwiftUI

@main
struct MarksAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

Do not modify this yet.

Understand the main parts:

```swift
@main
```

marks the starting point of the application.

```swift
App
```

is a SwiftUI protocol.

```swift
WindowGroup
```

creates the application's main window.

```swift
ContentView()
```

defines the first screen shown to the user.

This structure is covered directly in Lecture 05.

---

## 6. Exercise 01 – Your First SwiftUI View

Open:

```text
ContentView.swift
```

Replace the existing interface with:

```swift
import SwiftUI

struct ContentView: View {

    var body: some View {

        Text("Welcome to SE4041")
    }
}

#Preview {
    ContentView()
}
```

Run the application.

You should see:

```text
Welcome to SE4041
```

A SwiftUI screen is a `struct` that conforms to the `View` protocol, and its `body` is a computed property that describes what should appear on screen. SwiftUI is declarative: you describe the UI rather than manually drawing or updating controls.

---

## 7. Exercise 02 – View Modifiers

Modify the `Text`:

```swift
Text("Welcome to SE4041")
    .font(.title)
    .bold()
    .foregroundStyle(.blue)
    .padding()
```

Run the application again.

SwiftUI uses **modifiers** to change the appearance or layout of views.

Common modifiers include:

```swift
.font()
.foregroundStyle()
.padding()
.background()
.frame()
.bold()
.opacity()
```

Modifier order can affect the result because each modifier wraps and returns a new view.

---

### Experiment

Try:

```swift
Text("SE4041")
    .padding()
    .background(.orange)
```

Then change it to:

```swift
Text("SE4041")
    .background(.orange)
    .padding()
```

Run both versions.

Observe the difference.

---

## 8. Exercise 03 – Building Layouts with Stacks

SwiftUI provides three main stack types.

```text
VStack    Vertical
HStack    Horizontal
ZStack    Front-to-back
```

Replace your interface with:

```swift
struct ContentView: View {

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "graduationcap.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("SE4041")
                .font(.largeTitle)
                .bold()

            Text("Mobile Application Design & Development")

            HStack {

                Text("Practical 04")

                Spacer()

                Text("SwiftUI")
            }
            .padding()
        }
        .padding()
    }
}
```

Run the application.

---

### What is happening?

`VStack` places views vertically.

```swift
VStack {
}
```

`HStack` places views horizontally.

```swift
HStack {
}
```

`Spacer()` takes the available empty space and pushes views apart.

SwiftUI stacks, spacing, alignment, and `Spacer()` form the basic layout toolkit introduced in Lecture 05.

---

## 9. SF Symbols

The following code:

```swift
Image(systemName: "graduationcap.fill")
```

uses an **SF Symbol**.

SF Symbols are Apple's built-in system icons.

Try changing it to:

```swift
Image(systemName: "person.fill")
```

or:

```swift
Image(systemName: "book.fill")
```

or:

```swift
Image(systemName: "star.fill")
```

You can style a symbol using normal SwiftUI modifiers.

For example:

```swift
Image(systemName: "star.fill")
    .font(.largeTitle)
    .foregroundStyle(.orange)
```

---

## 10. Exercise 04 – `@State` and Buttons

Until now, the screen has displayed static information.

Now you will make the interface react to user interaction.

Replace `ContentView` with:

```swift
struct ContentView: View {

    @State private var count = 0

    var body: some View {

        VStack(spacing: 20) {

            Text("Button tapped \(count) times")
                .font(.title2)

            Button("Tap Me") {
                count += 1
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                count = 0
            }
        }
        .padding()
    }
}
```

Run the application.

Tap the button several times.

The number displayed on screen should automatically change.

---

### What does `@State` do?

```swift
@State private var count = 0
```

tells SwiftUI:

> This value belongs to this view and may change while the application is running.

Whenever a `@State` value changes, SwiftUI recomputes the view's `body` and updates the necessary part of the screen.

---

## 11. Exercise 05 – TextField and Binding

Now allow the user to enter data.

Replace the previous screen with:

```swift
struct ContentView: View {

    @State private var name = ""

    var body: some View {

        VStack(spacing: 20) {

            Text("Student Registration")
                .font(.title)
                .bold()

            TextField("Enter student name", text: $name)
                .textFieldStyle(.roundedBorder)

            if name.isEmpty {

                Text("Enter your name above")

            } else {

                Text("Welcome, \(name)")
            }
        }
        .padding()
    }
}
```

Run the application.

Enter a name.

The text below should update automatically.

---

## 12. Understanding `$name`

Notice:

```swift
TextField("Enter student name", text: $name)
```

The code uses:

```swift
$name
```

instead of:

```swift
name
```

`name` gives the current value.

`$name` provides a **binding**, allowing the `TextField` to read and modify the value.

Lecture 05 identifies this as a two-way connection between the control and the state.

---

## 13. Mini Activity – Student Result Input

Extend the screen.

Create:

```swift
@State private var studentName = ""
@State private var mark = ""
```

Add two text fields:

```swift
TextField("Student Name", text: $studentName)

TextField("Mark", text: $mark)
    .keyboardType(.numberPad)
```

Add a button:

```swift
Button("Show Result") {

}
```

For now, the button does not need to perform an action.

Make sure the interface appears correctly.

---

## 14. Exercise 06 – Creating a Model

Now create a model to represent a student.

Above `ContentView`, add:

```swift
struct Student: Identifiable {

    let id = UUID()

    var name: String
    var mark: Int

    var passed: Bool {
        mark >= 50
    }
}
```

This uses several concepts from Practical 03:

- structure,
- stored properties,
- computed property.

`Identifiable` gives SwiftUI a reliable way to distinguish items in a list. Lecture 05 uses the same model structure.

---

## 15. Exercise 07 – Displaying Data with `List`

Create sample data inside `ContentView`:

```swift
@State private var students = [

    Student(name: "Amal", mark: 72),
    Student(name: "Nimali", mark: 45),
    Student(name: "Ruwan", mark: 58)
]
```

Then create:

```swift
List(students) { student in

    HStack {

        Text(student.name)

        Spacer()

        Text("\(student.mark)")
            .bold()
    }
}
```

Run the application.

You should see a native scrolling list.

Lecture 05 introduces `List` as the standard way to produce rows from an array and explains why model objects need identity.

---

## 16. Show Pass and Fail Visually

Modify the mark:

```swift
Text("\(student.mark)")
    .bold()
    .foregroundStyle(
        student.passed ? .green : .red
    )
```

Now:

- passing marks are green,
- failing marks are red.

The `passed` rule belongs to the model rather than being repeated in the interface. This is also the pattern demonstrated in the lecture.

---

## 17. Exercise 08 – Navigation

Wrap the list inside:

```swift
NavigationStack {
}
```

Then add:

```swift
.navigationTitle("SE4041 Marks")
```

Your code should resemble:

```swift
NavigationStack {

    List(students) { student in

        HStack {

            Text(student.name)

            Spacer()

            Text("\(student.mark)")
        }
    }
    .navigationTitle("SE4041 Marks")
}
```

---

## 18. Create a Detail Screen

Create a new Swift file:

```text
StudentDetailView.swift
```

Add:

```swift
import SwiftUI

struct StudentDetailView: View {

    let student: Student

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))

            Text(student.name)
                .font(.largeTitle)
                .bold()

            Text("Mark: \(student.mark)")
                .font(.title2)

            Text(student.passed ? "Pass" : "Fail")
                .font(.title)
                .bold()
                .foregroundStyle(
                    student.passed ? .green : .red
                )

            Spacer()
        }
        .padding()
        .navigationTitle("Student Details")
    }
}
```

---

## 19. Add `NavigationLink`

Return to your student list.

Change each row to:

```swift
NavigationLink {
    StudentDetailView(student: student)
} label: {

    HStack {

        Text(student.name)

        Spacer()

        Text("\(student.mark)")
    }
}
```

Run the application.

Tap a student.

The detail screen should open.

A `NavigationStack` manages the navigation history, while `NavigationLink` provides a destination that SwiftUI pushes when the user taps the row.

---

## 20. Knowledge Check

Before attempting the final task, make sure you can answer the following:

1. What is `ContentView`?
2. Why is a SwiftUI view declared as a `struct`?
3. What does `body` represent?
4. What is a modifier?
5. What is the difference between `VStack` and `HStack`?
6. What does `Spacer()` do?
7. What is an SF Symbol?
8. Why do we use `@State`?
9. What is the difference between `name` and `$name`?
10. What does `Button` execute when tapped?
11. What does `Identifiable` provide?
12. What does `List` do?
13. What is a `NavigationStack`?
14. What does `NavigationLink` do?
15. Why is a separate subview useful?

---

## 21. Final Practical Task – Student Marks App

You are now required to build and submit a small working iOS application.

This is your final practical task.

---

### Application Requirements

Create an application titled:

```text
SE4041 Marks
```

The application must allow a user to:

1. Enter a student's name.
2. Enter the student's mark.
3. Add the student to a list.
4. View all added students.
5. Identify whether each student has passed or failed.
6. Open a detail screen for each student.
7. Display the total number of students who have passed.

Lecture 05 itself suggests extending the marks application with a text field for adding students, a detail screen, and a count of passing students.

---

## 22. Part A – Student Model

Create:

```swift
struct Student: Identifiable {

    let id = UUID()

    var name: String
    var mark: Int

    var passed: Bool {
        mark >= 50
    }
}
```

---

## 23. Part B – State Variables

Inside `ContentView`, create:

```swift
@State private var students: [Student] = []

@State private var studentName = ""

@State private var markText = ""
```

---

## 24. Part C – Build the Input Interface

Your screen should include:

```text
Student Name
Mark
Add Student Button
```

Example:

```swift
VStack {

    TextField(
        "Student Name",
        text: $studentName
    )

    TextField(
        "Mark",
        text: $markText
    )
    .keyboardType(.numberPad)

    Button("Add Student") {

    }
}
```

Apply appropriate:

```swift
.textFieldStyle(.roundedBorder)
.padding()
```

---

## 25. Part D – Add a Student

Inside the button action:

1. Make sure the name is not empty.
2. Convert `markText` into an integer.
3. Make sure the mark is between `0` and `100`.
4. Create a `Student`.
5. Add the student to the array.
6. Clear the input fields.

One possible structure is:

```swift
Button("Add Student") {

    guard !studentName.isEmpty else {
        return
    }

    guard let mark = Int(markText) else {
        return
    }

    guard mark >= 0 && mark <= 100 else {
        return
    }

    let student = Student(
        name: studentName,
        mark: mark
    )

    students.append(student)

    studentName = ""
    markText = ""
}
```

This combines `guard` from Practical 03 with SwiftUI state.

---

## 26. Part E – Display the Student List

Use:

```swift
List(students) { student in
```

Each row should display:

```text
Student Name             Mark
```

Use:

```swift
Spacer()
```

between them.

The mark or result should visually distinguish pass and fail.

---

## 27. Part F – Detail Screen

Create:

```text
StudentDetailView
```

The detail screen should show:

- Student name
- Student mark
- Pass/Fail
- An SF Symbol

Use:

```swift
NavigationLink
```

to open the detail screen.

---

## 28. Part G – Passed Student Count

Calculate the number of students who passed.

You may use:

```swift
students.filter {
    $0.passed
}.count
```

Display:

```text
Passed Students: 3
```

The number should update automatically whenever another student is added.

---

## 29. Expected Application Flow

The application's first screen could appear similar to:

```text
--------------------------------
        SE4041 Marks
--------------------------------

Student Name
[________________________]

Mark
[________________________]

       [ Add Student ]

Passed Students: 2

--------------------------------

Amal                         72 >
Nimali                       45 >
Ruwan                        58 >

--------------------------------
```

Selecting:

```text
Amal
```

could show:

```text
--------------------------------
       Student Details
--------------------------------

             👤

            Amal

          Mark: 72

            PASS

--------------------------------
```

Your exact layout does not have to match this example.

You are encouraged to design a clean interface using standard SwiftUI components.

---

## 30. Additional Challenge

Complete this section if you finish the required application early.

Add a computed property to `Student`:

```swift
var grade: String {
```

Use:

```text
80...100 -> A
75..<80  -> A-
70..<75  -> B+
65..<70  -> B
60..<65  -> B-
55..<60  -> C+
45..<55  -> C
40..<45  -> C-
Below 40 -> F
```

Display the student's grade on the detail screen.

This combines the work from Practical 02 and Practical 03 with the SwiftUI interface.

---

## 31. Optional UI Improvement

If time permits, improve the visual design using:

```swift
Image(systemName:)
.font()
.bold()
.foregroundStyle()
.padding()
.background()
.frame()
```

Keep the interface simple and readable.

Do not add unnecessary decoration that makes the application harder to use.

---

## 32. Basic Interface Guidelines

When designing the application:

- Keep text readable.
- Give controls enough spacing.
- Use clear labels.
- Do not rely only on colour to communicate important information.
- Use familiar system controls.
- Use meaningful SF Symbols.
- Make button labels describe the action they perform.
- Ensure the application remains understandable in both light and dark appearance where possible.

Apple's Human Interface Guidelines can be used as an additional reference for interface design.

---

## 33. Testing

Before submission, test the following cases.

### Test 1 – Valid Student

```text
Name: Amal
Mark: 72
```

The student should be added.

---

### Test 2 – Failing Student

```text
Name: Nimali
Mark: 45
```

The student should be added and displayed as failing.

---

### Test 3 – Empty Name

```text
Name:
Mark: 60
```

The student should not be added.

---

### Test 4 – Invalid Mark

```text
Name: Ruwan
Mark: abc
```

The student should not be added.

---

### Test 5 – Mark Above 100

```text
Name: Ruwan
Mark: 120
```

The student should not be added.

---

### Test 6 – Navigation

Tap each student.

Confirm that the correct student's name, mark, and pass/fail status appear on the detail screen. Use the back button to return to the list.

### Test 7 – Passed Student Count

Add both passing and failing students. Confirm that the count includes only students with marks of 50 or higher and updates when a passing student is added.

### Test 8 – Boundary Marks

Test marks of `0`, `49`, `50`, and `100`. All four should be accepted. Marks below 50 should fail; marks of 50 or more should pass. A negative mark must not be added.

---

## 34. Screenshots

Create a `screenshots/` folder in the repository and include screenshots of your completed application:

| File | What to show |
|---|---|
| `01-Student-List.png` | The main screen with input fields, several students, passing and failing results, and the passed student count. |
| `02-Student-Details.png` | A selected student's name, mark, pass/fail result, and SF Symbol on the detail screen. |

Capture the running application in the iOS Simulator. Make sure all required information is readable.

---

## 35. Repository Structure

Organize your submission using a structure similar to:

```text
your-classroom-repository/
├── README.md
├── MarksApp/
│   ├── MarksApp.xcodeproj/
│   └── MarksApp/
│       ├── MarksAppApp.swift
│       ├── ContentView.swift
│       ├── Student.swift
│       ├── StudentDetailView.swift
│       └── Assets.xcassets/
└── screenshots/
    ├── 01-Student-List.png
    └── 02-Student-Details.png
```

The exact folder nesting may vary depending on where you saved the Xcode project. Include the Xcode project and all source files needed to open and run the application.

If you move the model into `Student.swift`, add `import Foundation` for `UUID` and remove the original model declaration from `ContentView.swift`. Keep only one declaration of `Student`.

---

## 36. Submission Requirements

Submit your work through the GitHub Classroom repository provided by your instructor.

Your repository must contain:

- The completed Xcode project.
- All Swift source files and required assets.
- The completed Student Marks App.
- The required screenshots in `screenshots/`.
- This `README.md`.

The final application must:

- Accept a student name and mark.
- Reject an empty name, a non-integer mark, and marks outside `0...100`.
- Add valid students to the list and clear the input fields.
- Display student names and marks.
- Distinguish pass and fail.
- Navigate to the correct student's detail screen.
- Display an automatically updated passed student count.
- Build and run without compiler errors.

Complete the exercises before submitting the final application.

---

## 37. GitHub Submission

From the root of your local repository, run:

```bash
git status
git add .
git commit -m "Complete SE4041 Practical 04"
git push
```

Open your repository on GitHub and confirm that the latest source files, Xcode project, README, and screenshots are present.

---

## 38. Final Submission Checklist

- [ ] All practical exercises have been completed.
- [ ] The Xcode project builds and runs in the iOS Simulator.
- [ ] SwiftUI views, stacks, and modifiers are used appropriately.
- [ ] `@State` manages changing values.
- [ ] Text fields use bindings to state.
- [ ] The `Student` model conforms to `Identifiable`.
- [ ] The model includes the computed `passed` property.
- [ ] Valid students can be added to the list.
- [ ] Invalid input does not add a student or crash the application.
- [ ] Input fields clear after a successful addition.
- [ ] Passing and failing results are clearly identifiable.
- [ ] Each student opens the correct detail screen.
- [ ] The passed student count updates correctly.
- [ ] The required testing cases have been checked.
- [ ] The interface is readable and clearly labelled.
- [ ] Required screenshots have been added.
- [ ] All required files have been committed and pushed to GitHub.
- [ ] The final submission has been verified on GitHub.

---

## 39. Useful Resources

- [SwiftUI documentation](https://developer.apple.com/documentation/swiftui)
- [Develop in Swift tutorials](https://developer.apple.com/tutorials/develop-in-swift)
- [The Swift Programming Language](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)
- [Xcode](https://developer.apple.com/xcode/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [GitHub documentation](https://docs.github.com/)

---

## End of Practical 04

By completing this practical, you have brought together your Swift language knowledge to build a working iOS application with SwiftUI.

You have created and run an Xcode project, designed interfaces using views and stacks, managed changing data with `@State`, connected text fields using bindings, displayed identifiable models in a list, and navigated to a detail screen.

The Student Marks App combines these concepts into a small application that accepts input, validates data, displays student results, and updates its interface as data changes.


---

## Student Submission

| | |
|---|---|
| **Student Name** | Abisheak S |
| **Student ID** | IT21244384 |
| **App** | `MarksApp/` – SE4041 Marks (SwiftUI, iOS 17+) |

### Project contents

| Path | Content |
|---|---|
| `MarksApp/MarksApp.xcodeproj` | Xcode project – open this in Xcode and press Run |
| `MarksApp/MarksApp/MarksAppApp.swift` | App entry point (`@main`, `WindowGroup`) |
| `MarksApp/MarksApp/ContentView.swift` | Final task – input form, validation, passed count, student list, `StudentRow` subview |
| `MarksApp/MarksApp/Student.swift` | `Student` model (`Identifiable`, computed `passed` and `grade`) |
| `MarksApp/MarksApp/StudentDetailView.swift` | Detail screen with SF Symbol, mark, pass/fail and grade |
| `MarksApp/MarksApp/Exercises/` | Exercises 01–08 and the mini activity as separate views with previews, plus Knowledge Check answers |
| `MarksApp/MarksAppUITests/` | UI tests covering Tests 1–8 from the testing section; they also capture the screenshots |
| `MarksApp/project.yml` | XcodeGen spec the project was generated from |

### Environment

The code was written on Windows. It was built with Xcode and run in the iOS Simulator on a macOS runner (GitHub Actions, `.github/workflows/ios.yml`). The UI tests enter the students, tap through the screens and take the screenshots from the running Simulator.

## My Practical Evidence

![Student list](screenshots/01-Student-List.png)
![Student details](screenshots/02-Student-Details.png)
![Failing student details](screenshots/03-Student-Details-Fail.png)

UI test run on the iPhone 16e Simulator (iOS 26.2): 4 tests, 0 failures - covering Tests 1-8 of the testing section.
