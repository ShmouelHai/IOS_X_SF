import SwiftUI

struct FormView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var birthDate = Date()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HeaderView()
            
            Form {
                CustomTextField(text: $firstName, placeholder: "First Name")
                CustomTextField(text: $lastName, placeholder: "Last Name")
                CustomTextField(text: $email, placeholder: "Email")
                CustomTextField(text: $phone, placeholder: "Phone")
                
                DatePicker("Birth Date",
                          selection: $birthDate,
                          displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .padding(.vertical, 4)
            }
            
            Button(action: saveAccount) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            .buttonStyle(ScaleButtonStyle())
        }
        .navigationTitle("New Client")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
    
    private func saveAccount() {
        let account = Account(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            birthDate: birthDate
        )
        
        if let jsonString = account.toJSON() {
            print("Account Details:")
            print(jsonString)
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.caption)
                .foregroundColor(.gray)
            TextField("", text: $text)
                .focused($isFocused)
                .textFieldStyle(.plain)
                .padding(.vertical, 4)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isFocused ? .blue : .gray)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
    }
}

#Preview {
    NavigationView {
        FormView()
    }
} 
