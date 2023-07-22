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
                    .foregroundColor(current == image ? Color("fb") : Color.black.opacity(0.3))
                    // Default frame to avoid resizing
                    .frame(height: 35)

                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)

                    // Matched geometry effect slide animation
                    if current == image {
                        Rectangle()
                            .fill(Color("fb"))
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            })
        })
    }
}


                HStack(spacing: 0) {
                    TabButton(current: $current, image: "house.fill", animation: animation)
                    TabButton(current: $current, image: "magnifyingglass", animation: animation)
                    TabButton(current: $current, image: "person.2.fill", animation: animation)
                }
                .background(Color.white)
