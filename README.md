//
//  PagerTabs0830App.swift
//  PagerTabs0830
//
//  Created by 张亚飞 on 2021/8/30.
//

import SwiftUI

@main
struct PagerTabs0830App: App {
    var body: some Scene {
        WindowGroup {
            ContentViewer()
        }
    }
}

struct ContentViewer: View {
    var body: some View {
        Homer()
    }
}

struct Homer: View {
    // Top edge value
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation

    @State var isHide = false
    @State private var offset: CGFloat = CGFloat(180)
    
    var header: some View {
            
            VStack(spacing: 0) {
                VStack(alignment: .center, spacing: 6) {
                    
                    Text("View rates for:")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                    
                    
                    Button(action: {
                        print("pressed")
                    }) {
                        HStack(spacing: 0) {
                            Text("Absa Bank Kenya Plc-Parkside some stuff")
                                .lineLimit(1)
                                .foregroundColor(.white)
                                .font(.system(size: 27, weight: .bold))
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    
                    Text("Good morning kudzai")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                }
                
                Button(action: {
                    print("pressed")
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Place new order")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                 Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.red)
        }

    var body: some View {
        VStack(spacing: 0) {
            // App Bar
            VStack(spacing: 22) {
                // Hide
                if !isHide {
                    header
                        .frame(height: offset <= 0 ? 0 : offset )
                }

                // Custom Tab Bar
                HStack(spacing: 0) {
                    TabButton(current: $current, image: "house.fill", animation: animation)
                    TabButton(current: $current, image: "magnifyingglass", animation: animation)
                    TabButton(current: $current, image: "person.2.fill", animation: animation)
                    TabButton(current: $current, image: "tv.fill", animation: animation)
                }
                .background(Color.white)
            }
            .padding(.top, top! + 10)
            .background(Color.white)
        

            // Content
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 0, content: {
                    // Geometry reader for getting location values
                    GeometryReader { reader -> AnyView in
                        let yAxis = reader.frame(in: .global).minY

                        // logic simple if goes below zero hide nav bar
                        if yAxis < 0 && !isHide {
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = true
                                }
                            }
                        }

                        if yAxis > 0 && isHide {
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = false
                                }
                            }
                        }

                        return AnyView(
                            Text("")
                                .frame(width: 0, height: 0)
                                .onChange(of: yAxis) { newval in
                                    offset = newval/2
                                    print(newval)
                                }
                        )
                        
                    }
                    .frame(width: 0, height: 0)

                    VStack(spacing: 15) {
                        ForEach(1...20, id: \.self) { index in
                            VStack(spacing: 10) {
                                HStack(spacing: 10) {
                                    Image("logo")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())

                                    VStack(alignment: .leading, spacing: 4, content: {
                                        Text("Kavsoft")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)

                                        Text("\(45 - index) Min")
                                    })

                                    Spacer(minLength: 0)
                                }

                                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                })
                .padding(.top)
            })
        }
        .background(Color.black.opacity(0.07))
        .ignoresSafeArea()
    }
}

struct TabButton: View {
    @Binding var current: String
    var image: String
    var animation: Namespace.ID

    var body: some View {
        Button(action: {
            withAnimation { current = image }
        }, label: {
            VStack(spacing: 5, content: {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(current == image ? Color.blue : Color.black.opacity(0.3))
                    // Default frame to avoid resizing
                    .frame(height: 35)

                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)

                    // Matched geometry effect slide animation
                    if current == image {
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            })
        })
    }
}
