import SwiftUI

// Exercise 03 - Layouts with stacks and SF Symbols
struct Exercise03View: View {
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

            // SF Symbols styled with normal modifiers
            HStack(spacing: 24) {
                Image(systemName: "person.fill")
                Image(systemName: "book.fill")
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
            }
            .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    Exercise03View()
}
