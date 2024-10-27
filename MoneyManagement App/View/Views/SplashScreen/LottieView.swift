//
//  LottieView.swift
//  MoneyManagement App
//
//  Created by Raquel on 25/10/24.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animation: LottieAnimation?
    var loopMode: LottieLoopMode = .loop
    var width: CGFloat
    var height: CGFloat

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: width),
            animationView.heightAnchor.constraint(equalToConstant: height),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


