import SwiftUI

// Exercise 01 - First SwiftUI view: a struct conforming to View, with body as a computed property
struct Exercise01View: View {
    var body: some View {
        Text("Welcome to SE4041")
    }
}

// Exercise 02 - View modifiers (each modifier wraps the view and returns a new one)
struct Exercise02View: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to SE4041")
                .font(.title)
                .bold()
                .foregroundStyle(.blue)
                .padding()

            // Experiment - padding before background: the orange includes the padding
            Text("SE4041")
                .padding()
                .background(.orange)

            // Background before padding: the orange only covers the text
            Text("SE4041")
                .background(.orange)
                .padding()
        }
    }
}

#Preview("Exercise 01") {
    Exercise01View()
}

#Preview("Exercise 02") {
    Exercise02View()
}
