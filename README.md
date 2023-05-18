# MiniSteamingApp
struct HalfModalViewModifier<ModalContent: View> : ViewModifier {

  @Binding var isShown: Bool
    let modalContent: ModalContent

   func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    ZStack {
                        if self.isShown {
                            Color.black.opacity(0.2)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    withAnimation(.easeOut(duration: 0.8)) {
                                        self.isShown = false
                                    }
                                }
              self.modalContent
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: isShown ? 3 : 0)
                                .offset(y: isShown ? geometry.size.height / 2 : geometry.size.height)
                                .transition(.move(edge: .bottom))
                                .animation(.easeOut(duration: 0.4))
                        }
                    }
                )
        }
    }
}

struct ContentView: View {
    @State private var showModal = false
    @State private var checkboxStates = Array(repeating: false, count: 5)
    @State private var radioSelected = 0
    var body: some View {
        Button(action: {
            self.showModal.toggle()
        }) {
            Text("Show modal")
        }
        .halfModal(isShown: $showModal) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Filter Order")
                        .font(.system(size: 18))
                    Spacer()
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.3)) {
                            self.showModal = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    ForEach(0..<5) { index in
                        HStack {
                            CheckboxView(isChecked: $checkboxStates[index])
                            Text("Checkbox \(index + 1)")
                                .font(.system(size: 18))
                        }
                    }
                }
                .padding([.top, .bottom], 16)
                Divider()
                VStack(alignment: .leading) {
                    RadioButtonView(selected: $radioSelected, number: 0)
                    RadioButtonView(selected: $radioSelected, number: 1)
                }
                Button(action: {
                    // Apply actions here
                }) {
                    Text("Apply")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

struct CheckboxView: View {
    @Binding var isChecked: Bool

   var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                isChecked.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(isChecked ? Color.red : Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(isChecked ? Color.red : Color.gray, lineWidth: 2.0)
                    )
                    .frame(width: 24, height: 24)
               if isChecked {
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 14, height: 10)
                }
            }
            .scaleEffect(isChecked ? 1.1 : 1.0)
        }
    }
}



struct RadioButtonView: View {
    @Binding var selected: Int
    let number: Int
    
   var body: some View {
        Button(action: {
            selected = number
        }) {
            HStack {
                Image(systemName: selected == number ? "largecircle.fill.circle" : "circle")
                    .frame(width: 20, height: 20)
                    .foregroundColor(.red)
                Text("Option \(number + 1)")
            }
        }
    }
}
