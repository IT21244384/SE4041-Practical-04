import Foundation

// Part A - Student model. Identifiable lets List tell the rows apart.
struct Student: Identifiable {
    let id = UUID()

    var name: String
    var mark: Int

    var passed: Bool {
        mark >= 50
    }

    // Additional challenge - grade bands from Practical 02 and 03
    var grade: String {
        switch mark {
        case 80...100: return "A"
        case 75..<80: return "A-"
        case 70..<75: return "B+"
        case 65..<70: return "B"
        case 60..<65: return "B-"
        case 55..<60: return "C+"
        case 45..<55: return "C"
        case 40..<45: return "C-"
        default: return "F"
        }
    }
}
