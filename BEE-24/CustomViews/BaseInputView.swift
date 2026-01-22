import SwiftUI

struct InputView: View {
    let placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    @FocusState private var isFocused: Bool

    var body: some View {
        if isMultiline {
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)), axis: .vertical)
                .lineLimit(1...5)
                .font(.appFont(size: 23))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.appGreenSecondary)
                .cornerRadius(20)
                .submitLabel(.done)
                .focused($isFocused)
                .onSubmit {
                    isFocused = false
                }
        } else {
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)))
                .font(.appFont(size: 23))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.appGreenSecondary)
                .cornerRadius(20)
                .submitLabel(.done)
                .focused($isFocused)
                .onSubmit {
                    isFocused = false
                }
        }
    }
}

#Preview {
    ZStack {
        Color(.appGreenDark)
        VStack(spacing: 20) {
            InputView(placeholder: "Enter your name", text: .constant(""), isMultiline: true)

            InputView(placeholder: "Enter your name", text: .constant("John Doe"), isMultiline: false)
        }
        .padding()
    }
}

