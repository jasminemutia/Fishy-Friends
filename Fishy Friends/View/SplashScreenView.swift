//
//  SplashScreenView.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            // Customise your SplashScreen here
            ZStack {
                // Background for the whole screen
                Color(hex: 0x7859B).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("LOGO")
                    .resizable() // agar gambar dapat diubah ukurannya
                           .scaledToFit() // agar gambar menyesuaikan kotak tanpa merubah aspek rasio
                           .frame(width: 170, height: 170) // ukuran gambar
                           .foregroundColor(Color(hex: 0xC5DFF8)) // warna gambar
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        self.size = 0.9
                        self.opacity = 1.2
                    }
                }
            }
//            .background(.black)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
