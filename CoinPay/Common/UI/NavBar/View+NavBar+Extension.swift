//
//  View+NavBar+Extension.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.06.2025.
//

import SwiftUI

extension View {
    func customNavBarTitle(_ title: String?) -> some View {
        self.preference(key: NavBarTitlePreferenceKey.self, value: title)
    }
    func customNavBarSubtitle(_ subtitle: String?) -> some View {
        self.preference(key: NavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    func customNavBarImage(_ image: Image?) -> some View {
        self.preference(key: NavBarImagePreferenceKey.self, value: image)
    }
    func customNavBarBackButtonHidden(_ isHidden: Bool) -> some View {
        self.preference(key: NavBarBackButtonHiddenPreferenceKey.self, value: isHidden)
    }
    func customNavBarTotalSteps(_ steps: Int) -> some View {
        self.preference(key: ProgressBarMaxStepsPreferenceKey.self, value: steps)
    }
    func customNavBarCurrentStep(_ step: Int) -> some View {
        self.preference(key: ProgressBarCurrentStepPreferenceKey.self, value: step)
    }
}
