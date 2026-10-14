import SwiftUI

// Exercise 06 - the Student model lives in Student.swift (one declaration only).

// Exercise 07 - Displaying data with List, with pass/fail colours from the model
struct Exercise07View: View {
    @State private var students = [
        Student(name: "Amal", mark: 72),
        Student(name: "Nimali", mark: 45),
        Student(name: "Ruwan", mark: 58)
    ]

    var body: some View {
        List(students) { student in
            HStack {
                Text(student.name)
                Spacer()
                Text("\(student.mark)")
                    .bold()
                    .foregroundStyle(student.passed ? Color.green : Color.red)
            }
        }
    }
}

// Exercise 08 - NavigationStack, navigationTitle and NavigationLink to the detail screen
struct Exercise08View: View {
    @State private var students = [
        Student(name: "Amal", mark: 72),
        Student(name: "Nimali", mark: 45),
        Student(name: "Ruwan", mark: 58)
    ]

    var body: some View {
        NavigationStack {
            List(students) { student in
                NavigationLink {
                    StudentDetailView(student: student)
                } label: {
                    HStack {
                        Text(student.name)
                        Spacer()
                        Text("\(student.mark)")
                    }
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }
}

#Preview("Exercise 07") {
    Exercise07View()
}

#Preview("Exercise 08") {
    Exercise08View()
}

// Knowledge Check
// 1. ContentView is the first screen of the app - the view WindowGroup shows at launch.
// 2. Views are lightweight descriptions of the UI; a value-type struct is cheap to recreate whenever state changes.
// 3. body is a computed property describing what the view shows on screen.
// 4. A modifier is a method like .font() or .padding() that returns a new, changed view.
// 5. VStack places views vertically; HStack places them horizontally.
// 6. Spacer() takes up the available empty space and pushes views apart.
// 7. An SF Symbol is one of Apple's built-in system icons, used with Image(systemName:).
// 8. @State stores a value owned by the view; when it changes SwiftUI redraws the view.
// 9. name is the current value; $name is a binding that lets a control read and change it.
// 10. A Button runs the closure (action) given to it when it is tapped.
// 11. A stable id so SwiftUI can tell each item in a list apart.
// 12. List builds scrolling rows from a collection.
// 13. A NavigationStack manages the navigation history between screens.
// 14. NavigationLink pushes a destination screen when the user taps it.
// 15. A subview keeps body small, makes the UI easier to read, and can be reused.
