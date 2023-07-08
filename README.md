//
//  StickyHeaderApp.swift
//  StickyHeader
//
//  Created by Le Bon B' Bauma on 03/12/2022.
//

import SwiftUI

@main
struct StickyHeaderApp: App {
    var body: some Scene {
        WindowGroup {
            AccessFxHome()
        }
    }
}


struct AccessFxHome: View {
    
    @State var hideNavCreateButton: Bool = true

    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
                VStack(spacing: 0) {
                    HStack {
                        
                        HStack {
                            Button(action: {
                                print("Menu Button Tapped")
                            }) {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.trailing, 8)
                            
                            Spacer()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Spacer()
                        
                        Text("Absa Access")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                print("Menu Button Tapped")
                            }) {
                                Image(systemName: "plus") // image name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color.white)
                            }
                            .padding(.trailing, 8)
                            .opacity(hideNavCreateButton ? 0 : 1)
                            
                            Button(action: {
                                print("Search Button Tapped")
                            }) {
                                Image(systemName: "gear") // image name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding()
                    .background(
                        Image("background_gradient")
                            .resizable()
                            .edgesIgnoringSafeArea(.top)
                    )
                    
                    Home(
                        hideNavCreateButton: $hideNavCreateButton,
                        safeArea: safeArea,
                        size: size
                    )
                    .ignoresSafeArea(.container, edges: .top)
                }
                .hideNavigationBar()
        }
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
    
    @Binding var hideNavCreateButton: Bool
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
                        
                        outerMinY < 50 ? (hideNavCreateButton = false) : (hideNavCreateButton = true)
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
        .hideNavigationBar()
        .accessFxNavBar(
            title: "Access FX",
            titleAction: { },
            leadingAction: { }
        )
//        .toolbar {
//            ToolbarItemGroup(placement: .navigationBarLeading) {
//                Button {
//                    withAnimation {
//                        //showSettingsView = true
//                    }
//                } label: {
//                    Image(systemName: "chevron.backward")
//                        .frame(width: 16, height: 16)
//                        .foregroundColor(Color.white)
//                }
//            }
//
//            ToolbarItemGroup(placement: .principal) {
//                Text("Access FX")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(.white)
//            }
//
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button {
//                    withAnimation {
//                        //showSettingsView = true
//                    }
//                } label: {
//                    Image(systemName: "plus")
//                        .frame(width: 16, height: 16)
//                        .foregroundColor(Color.white)
//                }.opacity(outerMinY < 38 ? 1 : 0)
//            }
//
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button {
//                    withAnimation {
//                        //showSettingsView = true
//                    }
//                } label: {
//                    Image(systemName: "gear")
//                        .frame(width: 16, height: 16)
//                        .foregroundColor(Color.white)
//                }
//            }
//        }
    }


    
    @ViewBuilder
    func Artwork() -> some View {
        let height = 220.0
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY > 0.9 ? 1 : max(0.1, minY / (height * 0.1))

            Image("background_gradient")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
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
                        .opacity(progress)
                        .background(
                            Image("background_gradient")
                                .resizable()
                                .frame(width: size.width, height: 250)
                        )
                        
                    }
                    .offset(y: safeArea.top + 30)
                })
                .offset(y: -minY)
        }
        .frame(height: height)
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
        .frame(height: 60)
        .onTapGesture {
            withAnimation { selectedTab = tags }
        }
    }
}





struct NavigationBarView: View {
    var title: String
    var imageTitle1: String?
    var imageTitle2: String?
    var titleAction: (() -> Void)?
    var leadingAction: (() -> Void)?
    var trailingAction1: (() -> Void)?
    var trailingAction2: (() -> Void)?
    
    var body: some View {
        HStack {
           
                Button(action: {
                    leadingAction?()
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.white)
                })
                .foregroundColor(.white)
        
            
            Spacer()
            
            Button(action: {
                titleAction?()
            }, label: {
                HStack {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(Color.white)
                        //.isHidden(titleAction == nil, remove: titleAction == nil)
                }
            })
            .foregroundColor(.white)
               
            
            Spacer()
            
            HStack {
                if trailingAction1 != nil && imageTitle1 != nil {
                    Button(action: {
                        trailingAction1?()
                    }, label: {
                        Image(systemName: imageTitle1!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.white)
                    })
                    .foregroundColor(.white)
                }
                
                if trailingAction2 != nil && imageTitle1 != nil {
                    Button(action: {
                        trailingAction2?()
                    }, label: {
                        Image(systemName: imageTitle2!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.white)
                    })
                    .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(
            Image("background_gradient")
                .resizable()
                .edgesIgnoringSafeArea(.top)
        )

    }
}

struct NavigationBarModifier: ViewModifier {
    var title: String
    
    var imageTitle1: String? = nil
    var imageTitle2: String? = nil
    var titleAction: (() -> Void)? = nil
    var leadingAction: (() -> Void)? = nil
    var trailingAction1: (() -> Void)? = nil
    var trailingAction2: (() -> Void)? = nil
    
    func body(content: Content) -> some View {
        VStack {
            NavigationBarView(title: title,
                              imageTitle1: imageTitle1,
                              imageTitle2: imageTitle2,
                              titleAction: titleAction,
                              leadingAction: leadingAction,
                              trailingAction1: trailingAction1,
                              trailingAction2: trailingAction2)
            content
        }
    }
}

extension View {
    func accessFxNavBar(
        title: String,
        imageTitle1: String? = nil,
        imageTitle2: String? = nil,
        titleAction: (() -> Void)? = nil,
        leadingAction: (() -> Void)? = nil,
        trailingAction1: (() -> Void)? = nil,
        trailingAction2: (() -> Void)? = nil
    ) -> some View {
        modifier(NavigationBarModifier(
            title: title,
            imageTitle1: imageTitle1,
            imageTitle2: imageTitle2,
            titleAction: titleAction,
            leadingAction: leadingAction,
            trailingAction1: trailingAction1,
            trailingAction2: trailingAction2))
    }
}

