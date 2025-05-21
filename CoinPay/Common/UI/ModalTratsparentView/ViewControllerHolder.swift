//
//  ViewControllerHolder.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 09.05.2025.
//

import SwiftUI
import UIKit

struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
        return ViewControllerHolder(value: windowScene?.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}
