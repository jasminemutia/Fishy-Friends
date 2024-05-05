//
//  PufferFish.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import SwiftUI


struct PufferFish: View {
    @State private var gifName = "Puffer Fish"
    
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
                                self.gifName = "Puffer Eat"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                    self.gifName = "Puffer Fish"
                                }
                            }) {
                                Image("Eat")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)                            }
                            
                            Button(action: {
                                self.gifName = "Puffer Sleep"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    self.gifName = "Puffer Fish"
                                }
                            }) {
                                Image("Sleep")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                            
                            
                            Button(action: {
                                self.gifName = "Puffer Sick"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    self.gifName = "Puffer Fish"
                                }
                            }) {
                                Image("Sick")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                           
                            
//                            NavigationLink(destination: MinigamesSceneViewRepresentable()) {
//                                Image("Game")
//                                    .resizable()
//                                    .frame(width: 72.0, height: 72.0)
//                            }
                            Spacer()
                        }
                        Spacer()
                        
                        
                       
                        TabView{
                            GifImageView(name: $gifName)
                                .frame(width: 200, height: 200)
                                .scaleEffect(1.5)
                            
    //                        GifImageView(name: $gifName1)
    //                            .frame(width: 200, height: 200)
    //                            .scaleEffect(1.5)
                            
                            
                        } // vstack
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        HStack{
                            NavigationLink(destination: ContentView()) {
                                Image("Game")
                                    .resizable()
                                    .frame(width: 72, height: 72)
                            }
                            
                            NavigationLink(destination: SceneKitView()) {
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

struct PufferFish_Previews: PreviewProvider {
    static var previews: some View {
        PufferFish()
    }
}

