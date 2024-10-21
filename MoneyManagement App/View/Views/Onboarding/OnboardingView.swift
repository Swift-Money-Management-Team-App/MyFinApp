import SwiftUI

struct OnboardingView: View {
    @Binding var  isFirstLaunch: Bool
    var body: some View {
        VStack (alignment: .center) {
            Text("""
                    Bem vindo ao
                    PiggyBank!
                    """)
            .font(.system(.title, design: .default, weight: .bold))
            .multilineTextAlignment(.center)
            .padding(.top, 40)
            GeometryReader { bounds in
                VStack(spacing: 50) {
                    HStack(spacing: 10){
                        Image(systemName: "pencil.and.list.clipboard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (bounds.size.width * 0.2) - 10,height: 40)
                            .foregroundStyle(Color("Onboarding/Image1"))
                        
                        VStack{
                            Text("Registre suas finanças")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Controle todos os ganhos e gastos  num só lugar.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: bounds.size.width * 0.6, alignment: .leading)
                    }
                    .frame(width: bounds.size.width * 0.8)
                    HStack(spacing: 10){
                        Image(systemName: "dollarsign.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (bounds.size.width * 0.2) - 10,height: 40)
                            .foregroundStyle(Color("Onboarding/Image2"))
                        VStack{
                            Text("Gerencie suas finanças")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Organize onde está o seu dinheiro, adicionando várias instituições financeiras.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: bounds.size.width * 0.6, alignment: .leading)
                    }
                    .frame(width: bounds.size.width * 0.8)
                    HStack(spacing: 10){
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: (bounds.size.width * 0.2) - 10,height: 40)
                            .foregroundStyle(Color("Onboarding/Image3"))
                        VStack{
                            Text("Visualize seu Patrimônio")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Acompanhe o seu desempenho financeiro.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(width: bounds.size.width * 0.6, alignment: .leading)
                    }
                    .frame(width: bounds.size.width * 0.8)
                }
                .frame(width: bounds.size.width * 0.8)
                .frame(maxHeight: .infinity)
                .padding([.leading, .trailing], bounds.size.width * 0.1)
            }
            Button(action: { isFirstLaunch = false }, label: {
                Text("Começar")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
            })
            .background(Color("Onboarding/ButtonColor"))
            .clipShape(.rect(cornerRadius: 10, style: .circular))
            .padding(.horizontal, 40)
        }
        .frame(maxHeight: .infinity)
    }
    
}

#Preview {
    OnboardingView(isFirstLaunch: Binding.constant(true))
}
