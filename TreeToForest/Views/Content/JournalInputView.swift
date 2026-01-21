//
//  JournalInputView.swift
//  TreeToForest
//
//  Created by AI on 2026/01/21.
//

import SwiftUI
import Combine

struct JournalInputView: View {
    @Binding var isPresented: Bool
    @State private var text: String = ""
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isFocused: Bool // 焦点状态
    private let limit = 100
    
    // 如果是查看模式，传入内容
    var initialContent: String? = nil
    var isReadOnly: Bool = false
    
    var onSave: ((String) -> Void)?
    
    init(isPresented: Binding<Bool>, initialContent: String? = nil, isReadOnly: Bool = false, onSave: ((String) -> Void)? = nil) {
        self._isPresented = isPresented
        self.initialContent = initialContent
        self.isReadOnly = isReadOnly
        self.onSave = onSave
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    if isReadOnly {
                        isPresented = false
                    } else {
                        hideKeyboard()
                    }
                }
            
            VStack(spacing: 20) {
                // 标题
                Text(isReadOnly ? AppStrings.viewJournal : AppStrings.writeJournal)
                    .font(AppFonts.title2)
                    .foregroundColor(AppColors.textBrown)
                
                // 输入框
                ZStack(alignment: .topLeading) {
                    if text.isEmpty && !isReadOnly {
                        Text(AppStrings.journalPlaceholder)
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(8)
                    }
                    
                    if isReadOnly {
                        ScrollView {
                            Text(text)
                                .font(AppFonts.body)
                                .foregroundColor(AppColors.textBrown)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                        }
                    } else {
                        TextEditor(text: $text)
                            .focused($isFocused) // 绑定焦点
                            .font(AppFonts.body)
                            .foregroundColor(AppColors.textBrown)
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            .onChange(of: text) { newValue in
                                if newValue.count > limit {
                                    text = String(newValue.prefix(limit))
                                }
                            }
                    }
                }
                .frame(height: 150)
                .background(Color.white)
                .cornerRadius(8)
                
                // 字数统计 (仅编辑模式)
                if !isReadOnly {
                    HStack {
                        Spacer()
                        Text("\(text.count)/\(limit)")
                            .font(.caption)
                            .foregroundColor(text.count == limit ? .red : .gray)
                    }
                }
                
                // 按钮区域
                HStack(spacing: 20) {
                    if isReadOnly {
                        Button(action: {
                            isPresented = false
                        }) {
                            Text(AppStrings.iKnowIt)
                                .font(AppFonts.button)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(AppColors.primaryBlue)
                                .cornerRadius(12)
                        }
                    } else {
                        Button(action: {
                            isPresented = false
                        }) {
                            Text(AppStrings.cancel)
                                .font(AppFonts.button)
                                .foregroundColor(AppColors.textBrown)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                        
                        Button(action: {
                            if !text.isEmpty {
                                onSave?(text)
                                isPresented = false
                            }
                        }) {
                            Text(AppStrings.save)
                                .font(AppFonts.button)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(text.isEmpty ? Color.gray : AppColors.primaryBlue)
                                .cornerRadius(12)
                        }
                        .disabled(text.isEmpty)
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(20)
            .padding(24)
            .shadow(radius: 10)
            .offset(y: -keyboardHeight / 2) // 键盘弹出时上移
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
        }
        .onAppear {
            if let content = initialContent {
                text = content
            }
            
            // 如果不是只读模式，自动聚焦拉起键盘
            if !isReadOnly {
                // 稍微延迟一点以确保视图已完全加载
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFocused = true
                }
            }
            
            // 监听键盘通知
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                self.keyboardHeight = 0
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    JournalInputView(isPresented: .constant(true))
}
