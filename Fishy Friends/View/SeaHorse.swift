//
//  SeaHorse.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import SwiftUI


struct SeaHorse: View {
    @State private var gifName = "Sea Horse"
    
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
                                self.gifName = "Seahore eat"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                                    self.gifName = "Sea Horse"
                                }
                            }) {
                                Image("Eat")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)                            }
                            
                            Button(action: {
                                self.gifName = "Seahore Sleep"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    self.gifName = "Sea Horse"
                                }
                            }) {
                                Image("Sleep")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                            
                            
                            Button(action: {
                                self.gifName = "Seahorse sick"
                                // for interval 5 seconds, it will change to the former gif
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                                    self.gifName = "Sea Horse"
                                }
                            }) {
                                Image("Sick")
                                    .resizable()
                                    .frame(width: 72.0, height: 72.0)
                            }
                            Spacer()
                        }
                        Spacer()
                        
                        
                       
                        TabView{
                            GifImageView(name: $gifName)
                                .frame(width: 300, height: 400)
                                .scaleEffect(0.75)
                            
                        } // vstack
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        HStack{
                            NavigationLink(destination: ContentView()) {
                                Image("Game")
                                    .resizable()
                                    .frame(width: 72, height: 72)
                            }
                            
                            NavigationLink(destination: SceneKitView2()) {
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

struct SeaHorse_Previews: PreviewProvider {
    static var previews: some View {
        SeaHorse()
    }
}




