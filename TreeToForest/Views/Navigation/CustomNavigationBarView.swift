import SwiftUI

struct CustomNavigationBarView: View {
    let onQuestionTap: () -> Void
    let onPrivacyTap: () -> Void
    
    var body: some View {
        
        ZStack {
            HStack {
                Spacer()
                Text("Hulm")
                    .font(AppFonts.title2)
                    .foregroundColor(AppColors.textWhite)
                Spacer()
            }
            HStack {
                Spacer()
                HStack(spacing: 6) {
                    // 问号按钮
                    Button(action: onQuestionTap) {
                        Image("返回 1")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                            .foregroundColor(AppColors.textWhite)
                    }
                    Button(action: onPrivacyTap) {
                        Image("返回 2")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                    }
                }
            }
        }
        .padding(.horizontal, AppSpacing.navigationBarPadding)
        .frame(height: AppSpacing.navigationBarHeight)
        .background(Color.clear)
    }
}

#Preview {
    CustomNavigationBarView(
        onQuestionTap: {},
        onPrivacyTap: {}
    )
    .background(Color.blue)
}
