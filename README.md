
import SwiftUI

import SwiftUI

struct ContentView: View {
 
//    init() {
//        //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
//        UINavigationBar.appearance().backgroundColor = UIColor.clear
//        UINavigationBar.appearance().barTintColor = UIColor.init(
//            red: 0.3841539025,
//            green: 0.03335759789,
//            blue: 0.1798594594,
//            alpha: CGFloat(1.0))
//    }
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        
                        Text("Absa Access")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 99/255, green: 9/255, blue: 51/255),
                                Color(red: 135/255,  green: 22/255, blue: 61/255)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing)
                        .edgesIgnoringSafeArea(.top)
                    )
                    
                    Home(safeArea: safeArea, size: size)
                        .ignoresSafeArea(.container, edges: .top)
                }
                .hideNavigationBar()
        }
//        GeometryReader {
//            let safeArea = $0.safeAreaInsets
//            let size = $0.size
//            NavigationView {
//                Home(safeArea: safeArea, size: size)
//                    .ignoresSafeArea(.container, edges: .top)
//                    .navigationBarTitle("Try it!", displayMode: .inline)
//            }
//        }
    }
    
}

struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationTitle("")
            .navigationViewStyle(.stack)
    }
}

extension View {
    func hideNavigationBar() -> some View {
        modifier(HideNavigationBarModifier())
    }
}




struct Home: View {
    
    @State private var selectedTab = 1
    @State private var outerMinY = CGFloat(1000.0)
    // MARK: - Properties
    
    var safeArea: EdgeInsets
    var size: CGSize
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // MARK: - Artwork
                Artwork()
                
                // Since We ignored Top Edge
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    VStack(alignment: .leading, spacing: 0) {
                  
                        HStack(spacing: 0) {
                            tabButton(title: "One", tags: 1)
                            tabButton(title: "Two", tags: 2)
                            tabButton(title: "Three", tags: 3)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .font(.headline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 50) : 0)
                    .onChange(of: minY) { newValue in
                        outerMinY = newValue
                    }
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                VStack{

                    // MARK: - Album View
                    if selectedTab == 1 {
                        AlbumView()
                    } else {
                        
                        Rates()
                    }
                }
                .background(Color(red: 0.949, green: 0.949, blue: 0.949, opacity: 1.0))
                .zIndex(0)
                
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        //showSettingsView = true
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                        .frame(width: 16, height: 16)
                        .tint(Color.white)
                }
            }
            
            ToolbarItemGroup(placement: .principal) {
                Text("Access FX")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        //showSettingsView = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 16, height: 16)
                        .tint(Color.white)
                }.opacity(outerMinY < 38 ? 1 : 0)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        //showSettingsView = true
                    }
                } label: {
                    Image(systemName: "gear")
                        .frame(width: 16, height: 16)
                        .tint(Color.white)
                }
            }
        }
    }
    
    @ViewBuilder
       func Artwork() -> some View {
           let height = 220.0
           GeometryReader{ proxy in
               
               let size = proxy.size
               let minY = proxy.frame(in: .named("SCROLL")).minY
               let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
               
               Image("background_gradient")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: size.width, height: size.height )
                   .clipped()
                   .overlay(content: {
                       ZStack(alignment: .bottom) {
                           

                           VStack(spacing: 0) {
                               
                               Text("View Orders for:")
                                   .foregroundColor(Color.white)
                                   .font(.system(size: 12))
                                   .padding(.top, 8)
                               
                               HStack(alignment: .center) {
                                   Text("Dunken Miler")
                                       .foregroundColor(Color.white)
                                       .font(.system(size: 27, weight: .semibold))
                                       .padding(.top, 4)

                               }
                               
                               Text("Sales for, Mel")
                                   .foregroundColor(Color.white)
                                   .font(.system(size: 16))
                                   .padding(.top, 4)

                               Spacer()
                           }
                           .frame(width: UIScreen.main.bounds.width, height: 180)
                           .background(
                               Image("background_gradient")
                                   .resizable()
                                   .frame(width: size.width, height: size.height )
                           )
                           .opacity(1 + (progress > 0 ? -progress : progress))
                       }
                       .offset(y: safeArea.top)
                   })
                   .offset(y: -minY)
               
                
           }
           .frame(height: height + safeArea.top )
       }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing:  25) {
            ForEach(albums.indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text(albums[index].albumName)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("2,282,938")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                    
                }
                
            }
        }
        .padding(15)
    }
    
    @ViewBuilder
    func Rates() -> some View {
        VStack(spacing:0) {
            
            ForEach(1...35,id: \.self) { i in
                
                VStack {
                    HStack {
                        Text("test")
                            .font(.body)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .fixedSize()
                        
                        Spacer()
                        
                        Text("test desc")
                            .font(.body)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }

            }
        }
    }
    
    func tabButton(title: String, tags: Int) -> some View {
        VStack {
            Spacer()
            Text("First Tab").foregroundColor(selectedTab == tags ? .red : .gray).font(.headline)
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == tags ? .red : .gray)
            
            Spacer()
            
            Color(selectedTab == tags ? .red : .clear)
                .frame(height: 4)
        }
        .frame(height: 50)
        .onTapGesture {
            withAnimation { selectedTab = tags }
        }
    }
}

