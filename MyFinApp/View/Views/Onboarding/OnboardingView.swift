import SwiftUI

struct OnboardingView: View {
    @Binding var isFirstLaunch: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text(LocalizedStringKey.onboardingWelcomeTitle.label)
                .font(.system(.title, design: .default, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            GeometryReader { bounds in
                VStack(spacing: 50) {
                    OnboardingFeatureView(
                        icon: "pencil.and.list.clipboard",
                        color: Color("Onboarding/Image1"),
                        title: LocalizedStringKey.onboardingRegisterTitle.label,
                        description: LocalizedStringKey.onboardingRegisterDescription.label,
                        bounds: bounds
                    )

                    OnboardingFeatureView(
                        icon: "dollarsign.circle",
                        color: Color("Onboarding/Image2"),
                        title: LocalizedStringKey.onboardingManageTitle.label,
                        description: LocalizedStringKey.onboardingManageDescription.label,
                        bounds: bounds
                    )

                    OnboardingFeatureView(
                        icon: "chart.line.uptrend.xyaxis",
                        color: Color("Onboarding/Image3"),
                        title: LocalizedStringKey.onboardingVisualizeTitle.label,
                        description: LocalizedStringKey.onboardingVisualizeDescription.label,
                        bounds: bounds
                    )
                }
                .frame(width: bounds.size.width * 0.8)
                .frame(maxHeight: .infinity)
                .padding([.leading, .trailing], bounds.size.width * 0.1)
            }

            Button(action: {
                isFirstLaunch = false
                Storage.share.firstLaunchApplication = false
            }, label: {
                Text(LocalizedStringKey.onboardingButtonStart.button)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
            })
            .background(Color("Onboarding/ButtonColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 40)
        }
        .frame(maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

struct OnboardingFeatureView: View {
    let icon: String
    let color: Color
    let title: String
    let description: String
    let bounds: GeometryProxy

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: (bounds.size.width * 0.2) - 10, height: 40)
                .foregroundStyle(color)

            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(width: bounds.size.width * 0.6, alignment: .leading)
        }
        .frame(width: bounds.size.width * 0.8)
    }
}

#Preview {
    OnboardingView(isFirstLaunch: Binding.constant(true))
}
