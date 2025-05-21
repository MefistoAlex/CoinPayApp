//
//  UIViewController+Extension.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 09.05.2025.
//

import UIKit
import SwiftUI

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic,
                                transitionStyle: UIModalTransitionStyle = .coverVertical,
                                @ViewBuilder builder: () -> Content) {
        
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}
