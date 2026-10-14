import SwiftUI

// Exercise 04 - @State and buttons: changing count makes SwiftUI recompute body
struct Exercise04View: View {
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

// Exercise 05 - TextField and binding: $name gives the TextField two-way access to the state
struct Exercise05View: View {
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

// Mini Activity - Student result input
struct StudentResultInputView: View {
    @State private var studentName = ""
    @State private var mark = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Student Name", text: $studentName)
                .textFieldStyle(.roundedBorder)

            TextField("Mark", text: $mark)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            Button("Show Result") {
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview("Exercise 04") {
    Exercise04View()
}

#Preview("Exercise 05") {
    Exercise05View()
}

#Preview("Mini Activity") {
    StudentResultInputView()
}
