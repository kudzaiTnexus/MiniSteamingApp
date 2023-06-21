class BaseSearchableEntitiesViewModel: ObservableObject {}

final class AnySearchableEntitiesViewModel: BaseSearchableEntitiesViewModel {
    private let box: _AnySearchableEntitiesViewModelBox
    
   init<T: SearchableEntitiesViewModel>(_ viewModel: T) {
        box = _AnySearchableEntitiesViewModelBoxBase(viewModel)
    }
    
   var entities: [Any] {
        box.entities
    }
    // Add the rest of the properties and methods here, following the same pattern
}

private class _AnySearchableEntitiesViewModelBox {
    var entities: [Any] {
        fatalError("Must override")
    }
    // Add the rest of the properties and methods here, following the same pattern
}

private class _AnySearchableEntitiesViewModelBoxBase<T: SearchableEntitiesViewModel>: _AnySearchableEntitiesViewModelBox {
    private let base: T
    
   init(_ base: T) {
        self.base = base
    }
    
   override var entities: [Any] {
        base.entities
    }
    // Add the rest of the properties and methods here, following the same pattern
}

@ObservedObject var searchableEntitiesViewModel: BaseSearchableEntitiesViewModel

if  selectedTabIndex.wrappedValue == 1 {
    self.searchableEntitiesViewModel = AnySearchableEntitiesViewModel(SearchableEntitiesViewModel<OrderListLegalEntity, OrderListLegalEntityFactory>(selectedEntities: viewModel.selectedEntities, entityFactory: OrderListLegalEntityFactory()))
} else {
    self.searchableEntitiesViewModel = AnySearchableEntitiesViewModel(SearchableEntitiesViewModel<DealListLegalEntity, DealListLegalEntityFactory>(selectedEntities: dealsViewModel.selectedEntities, entityFactory: DealListLegalEntityFactory()))
}



# MiniSteamingApp

     struct Album: Identifiable{
         var id = UUID().uuidString
         var albumName: String

     }


     var albums: [Album] = [

    
    Album(albumName: "Arsenal des belles mélodies"),
    Album(albumName: "Bloqué"),
    Album(albumName: "Se Yo"),
    Album(albumName: "Droit Chemin"),
    Album(albumName: "Destin"),
    Album(albumName: "Tokooos II"),
    Album(albumName: "Tokooos II Gold"),
    Album(albumName: "Science - Fiction"),
    Album(albumName: "Strandje Aan De Maas"),
    Album(albumName: "Inama"),
    Album(albumName: "Par Terre - A COLOR SHOW"),
    Album(albumName: "QALF infinity"),
    Album(albumName: "Berna Reloaded"),
    Album(albumName: "Flavour of Africa"),
    Album(albumName: "Control"),
    Album(albumName: "Gentleman 2.0"),
    Album(albumName: "Power 'Kosa Leka' : Vol 1"),
    Album(albumName: "Historia"),
    Album(albumName: "Tokooos"),
    Album(albumName: "Fleur Froide - Second état : la cristalisation"),
    
     ]


     import SwiftUI

    struct ContentView8: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            NavigationView {
                Home(safeArea: safeArea, size: size)
                    .ignoresSafeArea(.container, edges: .top)
            }
            //.toolbarBackground(Color("background_gradient"), for: .navigationBar)

        }
        .preferredColorScheme(.dark )
    }
    }

    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView8()
    }
    }

    struct Home: View {
    
    @State private var selectedTab = 1
    // MARK: - Properties
    
    var safeArea: EdgeInsets
    var size: CGSize
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // MARK: - Artwork
                Artwork()
                
                // Since We ignored Top Edge
                GeometryReader{ proxy in
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
                    .offset(y: minY < 38 ? -(minY - 38) : 0)
                }
                .frame(height: 50)
                //.padding(.top, -34)
                .zIndex(1)
                
                VStack{
     //                    Text("Popular")
    //                        .fontWeight(.heavy)
    //
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
            .background(Color(red: 0.949, green: 0.949, blue: 0.949, opacity: 1.0))
    //            .overlay(alignment: .top) {
    //                HeaderView()
    //            }
            
        }
        .background(Color(red: 0.949, green: 0.949, blue: 0.949, opacity: 1.0))
        .coordinateSpace(name: "SCROLL")
        .navigationTitle("SwiftUI")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func Artwork() -> some View {
        let height = size.height * 0.45
        GeometryReader{ proxy in
            
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            
            Image("background_gradient")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height )//+ (minY > 0 ? minY : 0 ))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        
    //                        // MARK: - Gradient Overlay
    //                        Rectangle()
    //                            .fill(
    //                                .linearGradient(colors: [
    //                                    Color("background_gradient").opacity(0 - progress),
    //                                    Color("background_gradient").opacity(0.1 - progress),
    //                                    Color("background_gradient").opacity(0.3 - progress),
    //                                    Color("background_gradient").opacity(0.5 - progress),
    //                                    Color("background_gradient").opacity(0.8 - progress),
    //                                    Color("background_gradient").opacity(1),
    //                                ], startPoint: .top, endPoint: .bottom)
    //                            )
                            VStack(spacing: 0) {
                            
                            Text("Trading on behalf of:")
                                .foregroundColor(Color.white)
                                .font(.system(size: 12))
                                .padding(.top, 8)
                                //.redacted(reason: .placeholder)
                            
                            HStack(alignment: .center) {
                                Text("ABC Holdings")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 27, weight: .semibold))
                                    .padding(.top, 4)

                            }
                            //.redacted(reason: .placeholder)
                            
                            Text("Good morning, Mike")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                                .padding(.top, 4)
                                //.redacted(reason: .placeholder)

                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 180)
                        .background( .green
     //                            Image("background_gradient")
    //                                .resizable()
                        )
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        //.padding(.bottom, 55)
                        
                        // Moving with Scroll View
                        
                        //.offset(y: minY < 0 ? minY : 0 )
                    }
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
                
                RateTickerView(
                    isBorderless: false,
                    firstFlag: "flag_usd",
                    secondFlag: "flag_zar",
                    currencyPair: "USDZAR",
                    sellValue: "13.2345",
                    buyValue: "12.8798",
                    tickerColor: .constant(Color.green)
                )
            }
        }
    }
    
    
    // MARK: - Header View
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress =  minY / height

            HStack(spacing: 15) {
                Button {

                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)


                Button {

                } label: {
                    Text("FOLLOWING")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }
                .opacity(1 + progress)

                Button {

                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .background(Color("background_gradient"))
            .overlay(content: {
                Text("Fally Ipupa")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal,.bottom], 15)
            .background(
                Color("background_gradient")
                    .opacity(-progress > 1 ? 1 : 0)
            )
            .offset(y: -minY)



        }
        .frame(height: 35)
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

    struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    }

    public struct RateTickerView: View {
    
    let isBorderless: Bool
    let firstFlag: String
    let secondFlag: String
    let currencyPair: String
    let sellValue: String
    let buyValue: String
    
    var tickerColor: Binding<Color>
    
    public init(
        isBorderless: Bool = false,
        firstFlag: String,
        secondFlag: String,
        currencyPair: String,
        sellValue: String,
        buyValue: String,
        tickerColor: Binding<Color>
    ) {
        self.isBorderless = isBorderless
        self.firstFlag = firstFlag
        self.secondFlag = secondFlag
        self.currencyPair = currencyPair
        self.sellValue = sellValue
        self.buyValue = buyValue
        self.tickerColor = tickerColor
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("CURRENCY")
                        .font(.body)
                        .foregroundColor(Color(UIColor.lightText))
                        .padding(.bottom, 8)
                        .lineLimit(1)
                        .fixedSize()
                        .isHidden(!isBorderless, remove: !isBorderless)
                    
                    HStack {
                        Image(firstFlag)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .overlay(Circle().stroke(Color(UIColor.lightText), lineWidth: 1))
                            .background(
                                Image(secondFlag)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                    .clipShape(Circle())
                                    .shadow(radius: 1)
                                    .overlay(Circle().stroke(Color(UIColor.lightText), lineWidth: 1))
                                    .offset(x: 13, y: 0)
                            )
                            .padding(.trailing, 10)
                        
                        HStack(spacing: 4) {
                            Text(currencyPair)
                                .font(.body)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                    .fixedSize()
                            
                            Image("ic_down_dark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .isHidden(!isBorderless, remove: !isBorderless)
                        }
                    }
                    
                }
                .padding(.leading, isBorderless ? 0 : 16)
                .padding(.trailing)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        Text("SELL")
                            .font(.body)
                            .foregroundColor(Color(UIColor.lightText))
                            .padding(.bottom, 1)
                            .isHidden(!isBorderless, remove: !isBorderless)
                        
                        Group {
                            
                            Text(sellValue.prefix(5))
                                .font(.caption).foregroundColor(tickerColor.wrappedValue) +
                            Text(sellValue.suffix(2))
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(tickerColor.wrappedValue)
                        }
                        .fixedSize()
                        .padding(.top, isBorderless ? 8 : 0)
                    }
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        Text("BUY")
                            .font(.body)
                            .foregroundColor(Color(UIColor.lightText))
                            .padding(.bottom, 1)
                            .isHidden(!isBorderless, remove: !isBorderless)
                        
                        Group {
                            Text(buyValue.prefix(5))
                                .font(.caption)
                                .foregroundColor(tickerColor.wrappedValue) +
                            Text(buyValue.suffix(2))
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(tickerColor.wrappedValue)
                        }
                        .fixedSize()
                        .padding(.top, isBorderless ? 8 : 0)
                    }
                    
                    Button {
                        
                    } label: {
                        Image("img_charts_overflow")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 20, height: 40)
                    .padding(.trailing, 8)
                    .isHidden(isBorderless, remove: isBorderless)
                    
                }
            }
            Spacer()
                .isHidden(!isBorderless, remove: !isBorderless)
            Divider()
                .isHidden(!isBorderless, remove: !isBorderless)
        }
        .frame(height: isBorderless ? 60 : 48)
        .background(Color.white)
        .cornerRadius(isBorderless ? 0 : 8)
        .shadow(radius:isBorderless ? 0 : 1)
        .padding(8)
    }
    }

    public extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
    }
  
    @available(iOS 13.0, *)
    public struct HiddenModifier: ViewModifier {
    
    private let isHidden: Bool
    private let remove: Bool
    
    public init(isHidden: Bool, remove: Bool = false) {
        self.isHidden = isHidden
        self.remove = remove
    }
    
    public func body(content: Content) -> some View {
        Group {
            if isHidden {
                if remove {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}

public class FxHomeViewController: FXViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UIHostingController with ContentView as its root view
        let hostingController = UIHostingController(rootView: FxHomeView())

        // Make sure to call this before adding the child view controller's view as a subview
        addChild(hostingController)

        // Add the SwiftUI view to the view controller's view hierarchy
        let hostingView = hostingController.view!
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingView)

        // Set constraints to make the hosting view fill the entire view controller
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: view.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Make sure to call this after adding the child view controller's view as a subview
        hostingController.didMove(toParent: self)
    }
}
