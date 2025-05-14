import SwiftUI
import Foundation

struct CountryPicker: View {
    @Binding var selectedCountry: Country
    
    var body: some View {
        Menu {
            ForEach(Country.all) { country in
                Button(action: {
                    selectedCountry = country
                }) {
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                        Text(country.code)
                    }
                }
            }
        } label: {
            HStack {
                Text(selectedCountry.flag)
                Text(selectedCountry.code)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(value: Country.france) { binding in
        CountryPicker(selectedCountry: binding)
    }
}

// Helper pour le preview
struct StatefulPreviewWrapper<Value: Equatable, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    var body: some View { content($value) }
} 
