//
//  NavBarPreferenceKey.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.06.2025.
//

import SwiftUI

struct ProgressBarMaxStepsPreferenceKey: PreferenceKey {
    static var defaultValue: Int = 0
    
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}

struct ProgressBarCurrentStepPreferenceKey: PreferenceKey {
    static var defaultValue: Int = 0
    
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}

struct NavBarTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct NavBarSubtitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct NavBarImagePreferenceKey: PreferenceKey {
    static var defaultValue: Image? = nil
    
    static func reduce(value: inout Image?, nextValue: () -> Image?) {
        value = nextValue()
    }
}

struct NavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}
