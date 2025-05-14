import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
            Text("IOS X SF")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding()
    }
}

#Preview {
    HeaderView()
} 
