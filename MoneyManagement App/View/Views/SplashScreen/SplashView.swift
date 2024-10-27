//
//  SplashViewController.swift
//  MoneyManagement App
//
//  Created by Raquel on 19/10/24.
//

import Foundation
import SwiftUI
import Lottie

struct SplashView: View {
    @State private var isActive = false
    @State private var animationOpacity = 0.0
    @State private var isFirstLaunch = true

    var body: some View {
        ZStack {
            Color.clear
                .edgesIgnoringSafeArea(.all)

            LottieView(animation: LottieAnimation.named("SplashScreenAnimation"), loopMode: .playOnce, width: 350, height: 350) // Ajuste o tamanho aqui
                .opacity(animationOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.0)) {
                        animationOpacity = 1.0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            animationOpacity = 0.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true
                        }
                    }
                }
        }
        .fullScreenCover(isPresented: $isActive) {
            OnboardingView(isFirstLaunch: $isFirstLaunch)
        }
    }
}




