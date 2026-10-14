import SwiftUI

// Final Practical Task - Student Marks App
struct ContentView: View {

    // Part B - State variables
    @State private var students: [Student] = []
    @State private var studentName = ""
    @State private var markText = ""
    @State private var errorMessage: String?

    @FocusState private var focusedField: Field?

    private enum Field {
        case name, mark
    }

    // Part G - recomputed whenever students changes, so the count updates automatically
    private var passedCount: Int {
        students.filter { $0.passed }.count
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                // Part C - Input interface
                VStack(alignment: .leading, spacing: 8) {
                    Text("Student Name")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    TextField("Student Name", text: $studentName)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.words)
                        .focused($focusedField, equals: .name)
                        .accessibilityIdentifier("nameField")

                    Text("Mark")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    TextField("Mark", text: $markText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .mark)
                        .accessibilityIdentifier("markField")

                    if let errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .accessibilityIdentifier("errorMessage")
                    }

                    Button {
                        addStudent()
                    } label: {
                        Label("Add Student", systemImage: "person.badge.plus")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 4)
                    .accessibilityIdentifier("addButton")
                }
                .padding()

                // Part G - Passed student count
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)

                    Text("Passed Students: \(passedCount)")
                        .bold()
                        .accessibilityIdentifier("passedCount")

                    Spacer()

                    Text("Total: \(students.count)")
                        .foregroundStyle(.secondary)
                        .accessibilityIdentifier("totalCount")
                }
                .padding(.horizontal)

                // Part E - Student list, Part F - navigation to the detail screen
                List(students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        StudentRow(student: student)
                    }
                }
                .listStyle(.plain)
                .overlay {
                    if students.isEmpty {
                        ContentUnavailableView(
                            "No Students Yet",
                            systemImage: "person.3",
                            description: Text("Add a student using the form above.")
                        )
                    }
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }

    // Part D - Validate the input, then add the student and clear the fields
    private func addStudent() {
        let name = studentName.trimmingCharacters(in: .whitespaces)

        guard !name.isEmpty else {
            errorMessage = "Please enter a student name."
            return
        }

        guard let mark = Int(markText) else {
            errorMessage = "Mark must be a whole number."
            return
        }

        guard mark >= 0 && mark <= 100 else {
            errorMessage = "Mark must be between 0 and 100."
            return
        }

        students.append(Student(name: name, mark: mark))

        studentName = ""
        markText = ""
        errorMessage = nil
        focusedField = nil
    }
}

// Reusable row subview - shows the result as text and colour, so it does not rely on colour alone
struct StudentRow: View {
    let student: Student

    var body: some View {
        HStack {
            Text(student.name)

            Spacer()

            Text("\(student.mark)")
                .bold()
                .foregroundStyle(student.passed ? Color.green : Color.red)

            Text(student.passed ? "Pass" : "Fail")
                .font(.caption)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(
                    (student.passed ? Color.green : Color.red).opacity(0.15),
                    in: Capsule()
                )
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("studentRow")
    }
}

#Preview {
    ContentView()
}
