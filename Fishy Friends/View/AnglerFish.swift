//
//  AnglerFish.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//


import Foundation
import SwiftUI

struct AnglerFish: View {
    
    @State private var gifName = "Angler Fish"
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("GBA")
                    .padding(.bottom, 25.0)
                    .frame(width: 100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/123.0)
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    Image("SeaBG")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Spacer()
                            .frame(height: 50)
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                self.gifName = "Angler eat"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                    self.gifName = "Angler Fish"
                                }
                            }) {
                                Image("Eat")
                                    .resizable()
                                    .frame(width: 72, height: 72)
                            }
                            
                            Button(action: {
                                self.gifName = "Lantern Sleep"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    self.gifName = "Angler Fish"
                                }
                            }) {
                                Image("Sleep")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                            
                            Button(action: {
                                self.gifName = "Angler Sick"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                                    self.gifName = "Angler Fish"
                                }
                            }) {
                                Image("Sick")
                                    .resizable()
                                    .frame(width: 72, height: 72)
                            }
                            Spacer()
                        }
                        Spacer()
                        
                        
                        TabView{
                            GifImageView(name: $gifName)
                                .frame(width: 300, height: 300)
                                .scaleEffect(1)
                            
                        } // vstack
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        HStack{
                            NavigationLink(destination: ContentView()) {
                                Image("Game")
                                    .resizable()
                                    .frame(width: 72, height: 72)
                            }
                            
                            NavigationLink(destination: SceneKitView1()) {
                                Image("Camera")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                        }
                        .padding()
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
            .frame(width: 350, height: 600)
        }
        .navigationBarBackButtonHidden(true)
    }


}
        

struct AnglerFish_Previews: PreviewProvider {
    static var previews: some View {
        AnglerFish()
    }
}


