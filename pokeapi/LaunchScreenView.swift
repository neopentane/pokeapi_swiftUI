//
//  LaunchScreenView.swift
//  neopokeapi
//
//  Created by Shreeram Kelkar on 12/11/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @ObservedObject var viewModel: LaunchScreenViewModel

    var body: some View {
        ZStack {
            
            Image("bgimg") // Replace "backgroundImage" with the name of your image asset
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            
            VStack(spacing: 16.0) {
                Spacer()
                
                Text("PokeApi call them all Pokemon.")
                    .font(Font.custom("Sora", size: 34).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .tracking(0.34)
                    .foregroundColor(.white)
                
                Text("Sample Pokedex with pokeapi.")
                    .font(Font.custom("Sora", size: 14))
                    .tracking(0.14)
                    .foregroundColor(Color(red: 0.66, green: 0.66, blue: 0.66))
                
                NavigationLink {
                    TabBarView()
                    
                } label: {
                    Text("Get Started")
                        .font(Font.custom("Sora", size: 16).weight(.semibold))
                        .foregroundColor(.white)
                }
                .navigationBarHidden(true)
                .frame(width: 315, height: 62)
                .background(Color(red: 0.78, green: 0.49, blue: 0.31))
                .cornerRadius(16)
                
            }
            .padding(.bottom, 80.0)

        }
    }
}

#Preview {
    LaunchScreenView(viewModel: LaunchScreenViewModel())
}
