
@available(iOS 15.0, *)
struct ContentViewr: View {
    @State var editMode = EditMode.active
    @State var users = [
        ("Uyu", true),
        ("Iwe", true),
        ("Inini", true),
        ("Isusu", true),
        ("Wangu", true),
        ("Uyu1", true),
        ("Iwe2", true),
        ("Inini3", false),
        ("Isusu4", false),
        ("Wangu5", false),
        ("Uyu6", false),
        ("Iwe7", false),
        ("Inini8", false),
        ("Isusu9", false),
        ("Wangu10", false)
    ]
    
    @State var countries = ["Kenya", "SA", "Zim", "Nigeria", "Uganda"]
    
    @State private var isCheckBoxActive = false
    @State private var showSelectionError = false
    @State private var showCurrencyPairSheet = false
    
    var body: some View {

        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Select the currency pairs you want to see")
                        .font(.headline)
                    
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
                .padding()
                
                Text("Currency pair jurisdiction")
                    .font(.callout)
                    .foregroundColor(.dimGray)
                    .padding(.leading)
                
                HStack {
                    Text("Kenya")
                        .padding([.leading, .trailing])
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.down")
                            .padding()
                            .foregroundColor(.textBlackShade)
                    }
                }
                
            }
            .overlay(alignment: .bottom) {
                LinearGradient(
                    colors: [.white.opacity(0.2), Color(.sRGB, white: 0.35, opacity: 0.5)],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 4)
                .opacity(0.3)
            }

            
            List {
                ForEach(users.indices, id: \.self) { index in
                    Toggle(isOn:
                           Binding(
                              get: { self.users[index].1 },
                              set: { newValue in
                                  if newValue == false && users.filter({ $0.1 == true }).count <= 1 {
                                      // This is the last true toggle, don't let it be set to false
                                      showSelectionError = true
                                  } else {
                                      showSelectionError = false
                                      self.users[index].1 = newValue
                                  }
                              }
                           )
                    ) {
                        Text(users[index].0)
                            .foregroundColor(Colors.darkTextColor.color)
                            .font(.system(size: 16, weight: .regular))
                        
                        let firstVisibleItemIndex = users.firstIndex { $0.1 == true
                        } ?? 0
                        if index == firstVisibleItemIndex && users[index].1 == true {
                            if showSelectionError {
                                Text("At least one currency pair must be selected")
                                    .foregroundColor(Colors.errorRedTextColor.color)
                                    .font(.system(size: 11, weight: .regular))
                            } else {
                                Text("Default when placing orders")
                                    .foregroundColor(Colors.lightTextColor.color)
                                    .font(.system(size: 11, weight: .regular))
                            }
                        }
                    }
                    .toggleStyle(CheckboxStyle())
                    .listRowSeparator(.hidden)
                }
                .onMove { indexSet, toOffSet in
                    users.move(fromOffsets: indexSet, toOffset: toOffSet)
                }
            }
            .listStyle(.plain)
            .environment(\.editMode, $editMode)
            
            VStack {
                Button {
                    
                    users.forEach{
                        print("\($0.0): \($0.1) ")
                    }

                } label: {
                    Text("Apply")
                        .foregroundColor(.white)
                        .font(.body)
                }
                .buttonStyle(
                    FxButtonStyle(ButtonTheme(type: .default,
                                              isFullWidth: true,
                                              backgroundColor: Colors.pinkHighlight.color))
                )
                .padding([.leading, .trailing])
            }
            .padding(.vertical)
            .overlay(alignment: .top) {
                LinearGradient(
                    colors: [.white.opacity(0.2), Color(.sRGB, white: 0.35, opacity: 0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 4)
                .opacity(0.3)
            }
            
        }
        
    }

    func fetchSomething() async {
        // demo, assume we update something long here
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    }
}

@available(iOS 15.0, *)
struct ContentViewr_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewr()
    }
}
