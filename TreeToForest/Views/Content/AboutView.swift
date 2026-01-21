//
//  AboutView.swift
//  TreeToForest
//
//  Created by AI on 2025/10/14.
//

import SwiftUI

struct AboutView: View {
    let appName: String
    let onPrivacyTap: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            // 灰度透明背景（与 “A message for you” 保持一致）
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture { onClose() }
            
            // 居中圆角卡片
            VStack(spacing: 16) {
                appIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                Text(appName)
                    .font(AppFonts.title)
                    .foregroundColor(AppColors.textBrown)
                
                Button(action: onPrivacyTap) {
                    HStack(spacing: 8) {
                        Image(systemName: "lock.shield")
                            .font(.system(size: 16, weight: .medium))
                        Text(AppStrings.aboutPrivacyPolicy)
                            .font(AppFonts.button)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(AppColors.primaryBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(20)
            .frame(maxWidth: 280)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
            // 动画：模仿 EnvironmentalMessageView（淡入 + 缩放）
            .transition(.scale(scale: 0.9).combined(with: .opacity))
            .animation(AppAnimations.easeInOut, value: UUID())
        }
    }
    
    // 加载应用主图标；若不可用则兜底
    private var appIcon: Image {
        // 从 Info.plist 读取主图标名，然后用 UIImage(named:)
        if let iconsDict = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primary = iconsDict["CFBundlePrimaryIcon"] as? [String: Any],
           let files = primary["CFBundleIconFiles"] as? [String],
           let iconName = files.last,
           let uiImage = UIImage(named: iconName) {
            return Image(uiImage: uiImage)
        }
        // 兜底尝试直接加载 AppIcon（若项目单独添加了同名图片资源则可用）
        if let uiImage = UIImage(named: "AppIcon") {
            return Image(uiImage: uiImage)
        }
        // 最终兜底
        return Image(systemName: "leaf")
    }
}

#Preview {
    AboutView(appName: AppStrings.appName, onPrivacyTap: {}, onClose: {})
}

