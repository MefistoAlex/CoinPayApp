//
//  OnboardingView.swift
//  CoinPay
//
//  Created by Alexandr Mefisto on 26.03.2025.
//

import SwiftUI


struct OnboardingView: View {
    
    var body: some View {
        
        AutoScroller(advantages: Advantages.allCases)
    }
}

struct AutoScroller: View {
    var advantages: [Advantages]
    
    @State private var selectedImageIndex: Int = 0

    var body: some View {
        VStack {
 
            TabView(selection: $selectedImageIndex) {
                 ForEach(0..<advantages.count, id: \.self) { index in
                    ZStack(alignment: .topLeading) {
                        Image(advantages[index].image)
                            .tag(index)
                            .frame(height: 260)
                    }
                }
            }
            .frame(height: 350)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.bottom, 80)
            .padding(.top, 48)

           
            HStack {
                ForEach(0..<advantages.count, id: \.self) { index in
                    Capsule()
                        .fill(selectedImageIndex == index ? Color.blue : Color.white)
                        .frame(width: selectedImageIndex == index ? 16 : 37, height: 8)
                        .onTapGesture {
                            selectedImageIndex = index
                        }
                }
            }
            
            Text(advantages[selectedImageIndex].title)
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
        }
    }
}
