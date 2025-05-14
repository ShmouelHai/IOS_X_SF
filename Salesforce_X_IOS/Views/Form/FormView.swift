import SwiftUI

struct FormView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var birthDate = Date()
    @State private var selectedCountry = Country.france
    @State private var showError = false
    @State private var errorMessage = ""
    @Environment(\.dismiss) private var dismiss
    
    private var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private var isPhoneValid: Bool {
        let digits = phone.filter { $0.isNumber }
        return digits.count == 9
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && isEmailValid && isPhoneValid
    }
    
    var body: some View {
        VStack {
            HeaderView()
            
            Form {
                Section {
                    CustomTextField(text: $firstName, placeholder: "First Name *")
                    CustomTextField(text: $lastName, placeholder: "Last Name *")
                    
//                    CustomTextField(text: $email, placeholder: "Email *", keyboardType: .emailAddress, autocapitalization: .none)
//                        .overlay(
//                            Group {
//                                if !email.isEmpty && !isEmailValid {
//                                    Text("Invalid email format")
//                                        .font(.caption2)
//                                        .foregroundColor(.red)
//                                        .padding(.top, 36)
//                                }
//                            }, alignment: .bottomLeading
//                        )
                    
                    HStack(spacing: 8) {
                        CountryPicker(selectedCountry: $selectedCountry)
                        CustomTextField(text: Binding(
                            get: { phone },
                            set: { newValue in
                                phone = String(newValue.filter { $0.isNumber }.prefix(9))
                            }),
                            placeholder: "Phone *",
                            keyboardType: .numberPad
                        )
                    }
                    .overlay(
                        Group {
                            if !phone.isEmpty && !isPhoneValid {
                                Text("Must be 9 digits")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                                    .padding(.top, 36)
                            }
                        }, alignment: .bottomLeading
                    )
                    
                    DatePicker("Birth Date",
                              selection: $birthDate,
                              displayedComponents: .date)
                        .datePickerStyle(.automatic)
                        .padding(.vertical, 4)
                }
                
                Section {
                    Text("* Required fields")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Button(action: saveAccount) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .padding()
            .buttonStyle(ScaleButtonStyle())
            .disabled(!isFormValid)
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
        .alert("Validation Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func saveAccount() {
        var missingFields: [String] = []
        
        if firstName.isEmpty { missingFields.append("First Name") }
        if lastName.isEmpty { missingFields.append("Last Name") }
        if email.isEmpty { missingFields.append("Email") }
        if !isEmailValid { missingFields.append("Email (invalid format)") }
        if phone.isEmpty { missingFields.append("Phone") }
        if !isPhoneValid { missingFields.append("Phone (must be 9 digits)") }
        
        if !missingFields.isEmpty {
            errorMessage = "Sorry, you didn't fill all required fields:\n" + missingFields.joined(separator: "\n")
            showError = true
            return
        }
        
        let account = Account(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: "\(selectedCountry.code) \(phone)",
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
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
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
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
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
