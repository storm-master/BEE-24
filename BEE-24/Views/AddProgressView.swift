import SwiftUI

struct AddProgressView: View {
    @Binding var isPresented: Bool
    var editingProgress: ProgressModel? = nil
    var onSave: () -> Void = {}
    
    @State private var result: String = ""
    @State private var goal: String = ""
    @State private var notes: String = ""
    @State private var date: Date = Date()
    @State private var showCalendar: Bool = false
    
    private var isEditing: Bool {
        editingProgress != nil
    }
    
    private var isFormValid: Bool {
        !result.isEmpty && !goal.isEmpty
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                ScrollView {
                    VStack(spacing: 5) {
                        HStack {
                            Text(isEditing ? "Edit record" : "Add record")
                                .font(.appFont(size: 30))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                if isFormValid {
                                    saveProgress()
                                }
                            } label: {
                                Image(isFormValid ? .doneButton : .doneButtonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 55)
                            }
                        }
                        VStack(spacing: 8) {
                            HStack {
                                Text("Best Attempt")
                                    .font(.appFont(size: 19))
                                    .foregroundColor(.white.opacity(0.5))
                                Spacer()
                                Text("hits")
                                    .font(.appFont(size: 19))
                                    .foregroundColor(.white)
                            }

                            HStack(spacing: 4) {
                                TextField("", text: $result, prompt: Text("0").foregroundColor(.white.opacity(0.5)))
                                    .font(.appFont(size: 50))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.numberPad)
                                    .frame(width: 60)
                                    .onChange(of: result) { newValue in
                                        let filtered = newValue.filter { $0.isNumber }
                                        if filtered.count > 3 {
                                            result = String(filtered.prefix(3))
                                        } else {
                                            result = filtered
                                        }
                                    }

                                Text("/")
                                    .font(.appFont(size: 50))
                                    .foregroundColor(result.isEmpty && goal.isEmpty ? .white.opacity(0.5) : .white)

                                TextField("", text: $goal, prompt: Text("0").foregroundColor(.white.opacity(0.5)))
                                    .font(.appFont(size: 50))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.numberPad)
                                    .frame(width: 60)
                                    .onChange(of: goal) { newValue in
                                        let filtered = newValue.filter { $0.isNumber }
                                        if filtered.count > 3 {
                                            goal = String(filtered.prefix(3))
                                        } else {
                                            goal = filtered
                                        }
                                    }
                            }
                        }
                        .padding()
                        .frame(width: 220)
                        .background(Color.appGreenSecondary)
                        .cornerRadius(23)

                        InputView(placeholder: "Notes", text: $notes, isMultiline: true)
                        
                        VStack(spacing: 5) {
                            Button {
                                withAnimation {
                                    showCalendar.toggle()
                                }
                            } label: {
                                HStack {
                                    Text(formattedDate.isEmpty ? "Date" : formattedDate)
                                        .font(.appFont(size: 23))
                                        .foregroundColor(formattedDate.isEmpty ? .white.opacity(0.5) : .white)
                                    
                                    Spacer()
                                    
                                    Image(.arrowDown)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45, height: 45)
                                        .rotationEffect(.degrees(showCalendar ? 180 : 0))
                                }
                                .padding(20)
                                .background(Color.appGreenSecondary)
                                .cornerRadius(20)
                            }
                            
                            if showCalendar {
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .tint(.white)
                                    .colorScheme(.dark)
                                    .padding()
                                    .background(Color.appGreenSecondary)
                                    .cornerRadius(26)
                                    .onChange(of: date) { _ in
                                        withAnimation {
                                            showCalendar = false
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(Color.appGreenDark)
            .cornerRadius(35)
            .padding(.horizontal, 20)
            .padding(.vertical, 60)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .onAppear {
            if let progress = editingProgress {
                result = String(progress.result)
                goal = String(progress.goal)
                notes = progress.notes
                date = progress.date
            }
        }
    }
    
    private func saveProgress() {
        if let existingProgress = editingProgress {
            var updatedProgress = existingProgress
            updatedProgress.result = Int(result) ?? 0
            updatedProgress.goal = Int(goal) ?? 0
            updatedProgress.notes = notes
            updatedProgress.date = date
            ProgressService.shared.update(updatedProgress)
        } else {
            let progress = ProgressModel(
                result: Int(result) ?? 0,
                goal: Int(goal) ?? 0,
                notes: notes,
                date: date
            )
            ProgressService.shared.add(progress)
        }
        onSave()
        isPresented = false
    }
}

#Preview {
    AddProgressView(isPresented: .constant(true))
}

