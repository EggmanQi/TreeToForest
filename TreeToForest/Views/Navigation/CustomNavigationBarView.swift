import SwiftUI

struct CustomNavigationBarView: View {
    let onQuestionTap: () -> Void
    let onPrivacyTap: () -> Void
    let onHistoryTap: () -> Void
    let onAboutTap: () -> Void
    
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
                    // About 按钮（位于最左侧）
                    Button(action: onAboutTap) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                            .foregroundColor(AppColors.textWhite)
                    }
                    // 历史记录按钮
                    Button(action: onHistoryTap) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                            .foregroundColor(AppColors.textWhite)
                    }
                    // 问号按钮
                    Button(action: onQuestionTap) {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                            .foregroundColor(AppColors.textWhite)
                    }
                    Button(action: onPrivacyTap) {
                        Image("privacy")
                            .resizable()
                            .frame(width: AppSizes.iconSmall, height: AppSizes.iconSmall)
                            .foregroundColor(AppColors.textWhite)
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
        onPrivacyTap: {},
        onHistoryTap: {},
        onAboutTap: {}
    )
    .background(Color.blue)
}
