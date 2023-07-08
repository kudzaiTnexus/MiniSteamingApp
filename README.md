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
        .padding(.top, getSafeAreaInsets().top - 65)
        .background(
            Image("background_gradient")
                .resizable()
                .edgesIgnoringSafeArea(.top)
        )

    }
    
    func getSafeAreaInsets() -> UIEdgeInsets {
        var insets = UIEdgeInsets()

        if #available(iOS 15.0, *) {
            // Fetch insets from first window of the current scene
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                insets = scene.windows.first?.safeAreaInsets ?? UIEdgeInsets()
            }
        } else {
            // Fallback on earlier versions
            insets = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets()
        }

        return insets
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
        VStack(spacing: 0) {
            NavigationBarView(title: title,
                              imageTitle1: imageTitle1,
                              imageTitle2: imageTitle2,
                              titleAction: titleAction,
                              leadingAction: leadingAction,
                              trailingAction1: trailingAction1,
                              trailingAction2: trailingAction2)
            content
        }
        .hideNavigationBar()
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
