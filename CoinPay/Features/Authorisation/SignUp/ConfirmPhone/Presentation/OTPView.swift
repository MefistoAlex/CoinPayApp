//
//  OTPView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 21.05.2025.
//

import SwiftUI
import Combine

struct OTPFieldView: View {
    
    @FocusState private var pinFocusState: FocusPin?
    @Binding private var otp: String
    @State private var pins: [String]
    
    var numberOfFields: Int
    
    enum FocusPin: Hashable {
        case pin(Int)
    }
    
    init(numberOfFields: Int, otp: Binding<String>) {
        self.numberOfFields = numberOfFields
        self._otp = otp
        self._pins = State(initialValue: Array(repeating: "", count: numberOfFields))
    }
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("", text: $pins[index])
                    .font(.title2)
                    .modifier(OtpModifier(pin: $pins[index]))
                    .foregroundColor(.blue100)
                    .onChange(of: pins[index], { oldValue, newValue in
                        if newValue.count == 1 {
                            if index < numberOfFields - 1 {
                                pinFocusState = FocusPin.pin(index + 1)
                            } else {
                                 pinFocusState = nil
                            }
                        }
                        else if newValue.count == numberOfFields {
                            otp = newValue
                            updatePinsFromOTP()
                            pinFocusState = FocusPin.pin(numberOfFields - 1)
                        }
                        else if newValue.isEmpty {
                            if index > 0 {
                                pinFocusState = FocusPin.pin(index - 1)
                            }
                        }
                        updateOTPString()
                    })
                    .focused($pinFocusState, equals: FocusPin.pin(index))
                    .onTapGesture {
                        pinFocusState = FocusPin.pin(index)
                    }
            }
        }
        .onAppear {
            updatePinsFromOTP()
        }
    }
    
    private func updatePinsFromOTP() {
        let otpArray = Array(otp.prefix(numberOfFields))
        for (index, char) in otpArray.enumerated() {
            pins[index] = String(char)
        }
    }
    
    private func updateOTPString() {
        otp = pins.joined()
    }
}

struct OtpModifier: ViewModifier {
    @Binding var pin: String
    
    var textLimit = 1
    
    func limitText(_ upper: Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in limitText(textLimit) }
            .frame(width: 40, height: 48)
            .font(.system(size: 14))
            .padding(2)
            .glassEffect(in: .circle)
//            .background(
//                RoundedRectangle(cornerRadius: 4)
//                    .stroke(Color.blue100, lineWidth: 1)
//            )
    }
}
