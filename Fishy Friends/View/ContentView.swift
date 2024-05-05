//
//  ContentView.swift
//  SplashScreen
//
//  Created by Jasmine Mutia Alifa on 27/04/24.
//

import SwiftUI


struct ContentView: View {

    @State private var gifName = "Puffer Fish"
    @State private var gifName1 = "Angler Fish"
    @State private var gifName2 = "Sea Horse"
    
    var body: some View {
//        let coordinator = Coordinator()
        
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
//                        Spacer()
//                            .frame(height: 100)
                        
                        HStack{
                            Spacer()
                            
//                            NavigationLink(destination: MinigamesSceneViewRepresentable()) {
//                                Image("Sleep")
//                                    .resizable()
//                                    .frame(width: 72, height: 72)
//                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                        
                        
                        TabView{
                            NavigationLink(destination: PufferFish()) {
                                GifImageView(name: $gifName)
                                    .frame(width: 200, height: 200)
                                    .scaleEffect(1.5)
                            }
                            
                            NavigationLink(destination: AnglerFish()) {
                                GifImageView(name: $gifName1)
                                    .frame(width: 300, height: 300)
                                    .scaleEffect(1)
                            }
                            NavigationLink(destination: SeaHorse()) {
                                GifImageView(name: $gifName2)
                                    .frame(width: 300, height: 400)
                                    .scaleEffect(0.75)
                            }
                            
                        } // vstack
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        
                        NavigationLink(destination: MinigamesSceneViewRepresentable()) {
                            Image("Game")
                                .resizable()
                                .frame(width: 72, height: 72)
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

    // create function to change gif by changing index value and after 5 seconds, it will change to the former gif
//    func changeGif(index: Int) {
//        self.index = index
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.index = 0
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
