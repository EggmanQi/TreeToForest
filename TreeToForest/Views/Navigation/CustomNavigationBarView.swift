import SwiftUI

struct CustomNavigationBarView: View {
    let onQuestionTap: () -> Void
    
    var body: some View {
        
        ZStack {
            HStack {
                Spacer()
                Text("TTF")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                Spacer()
                Button(action: onQuestionTap) {
                    Image("icon_question")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 44)
        .background(Color.clear)
    }
}

#Preview {
    CustomNavigationBarView(onQuestionTap: {})
        .background(Color.blue)
}
