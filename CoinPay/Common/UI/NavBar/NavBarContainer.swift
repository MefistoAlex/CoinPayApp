//
//  NavBarContainer.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.06.2025.
//

import SwiftUI

struct NavBarContainer<Content: View>: View {
    
    @State private var viewSize: CGSize = .zero
    @State private var title: String?
    @State private var subtitle: String?
    @State private var image: Image?
    @State private var isBackButtonHidden: Bool = false
    @State private var maxSteps: Int = 0
    @State private var currentStep: Int = 0
    var backButtonAction: (() -> Void)
    
    private let content: Content
    
    init(@ViewBuilder content: () -> Content, backButtonAction: @escaping () -> Void) {
        self.content = content()
        self.backButtonAction = backButtonAction
    }
    
    var body: some View {
        ZStack {
            content
                .safeAreaInset(edge: .top, spacing: 72) {
                    Color.clear.frame(maxHeight: 16)
                }
                .onPreferenceChange(NavBarTitlePreferenceKey.self) { title in
                    self.title = title
                }
                .onPreferenceChange(ProgressBarMaxStepsPreferenceKey.self) { maxSteps in
                    self.maxSteps = maxSteps
                }
                .onPreferenceChange(ProgressBarCurrentStepPreferenceKey.self) { currentStep in
                    self.currentStep = currentStep
                }
                .onPreferenceChange(NavBarBackButtonHiddenPreferenceKey.self) { isHidden in
                    self.isBackButtonHidden = isHidden
                }
            VStack(spacing: 0) {
                NavBarView(
                    totalSteps: maxSteps,
                    step: currentStep,
                    isBackButtonHidden: isBackButtonHidden,
                    title: title,
                    subtitle: subtitle,
                    image: image,
                    backButtonAction: backButtonAction
                )
                
                Spacer()
                
            }
        }
    }
}
