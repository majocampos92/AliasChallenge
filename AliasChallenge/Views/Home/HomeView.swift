import SwiftUI
import SkeletonUI
import Kingfisher

struct HomeView: View {
// MARK: - Parameters
    @StateObject var viewModel: HomeViewModel = .make()
    @State var contactName = Constants.empty
    @State var contactSheetOpen = false
    @State var item: String?
    
    private let columns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: Constants.galleryCardSpacing),
        count: Constants.galleryGridColumns
    )
// MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showEmptyState {
                    emptyState
                } else if contactName.isEmpty {
                    findPhotos
                } else {
                    photos
                }
                Search(searchText: $contactName, viewModel: viewModel) {
                    ///receives dismiss
                    contactSheetOpen = false
                }
            }
            .navigationBarTitle(Constants.homeTitle, displayMode: .inline)
        }
    }
// MARK: - Views
    var photos: some View {
        GeometryReader { geometry in
        let size = geometry.size.width / CGFloat(Constants.galleryGridColumns) - Constants.galleryCardSpacing
            List {
                LazyVGrid(columns: columns, spacing: Constants.galleryCardSpacing) {
                    /// Skeleton
                    SkeletonForEach(with: viewModel.photos, quantity: Constants.galleryLimitPerPage) { loading, photo in
                        let id = photo?.id ?? Constants.empty
                        let imageUrl = URL(string: photo?.getImageUrl(size: Constants.n) ?? Constants.empty)
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFill()
                            .skeleton(with: loading)
                            .shape(type: .rectangle)
                            .frame(width: size, height: size)
                            .clipped()
                            .background(
                                NavigationLink(
                                    destination: DetailView(
                                        id: id,
                                        photo: photo?.getImageUrl(size: Constants.w)
                                    ),
                                    tag: id,
                                    selection: $item,
                                    label: {
                                        EmptyView()
                                    }
                                )
                                .opacity(Double(Constants.zero))
                            )
                            .onTapGesture {
                                item = id
                            }
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                
                if !viewModel.galleryComplete {
                    HStack {
                        Spacer()
                        ProgressView()
                            .onAppear {
                                viewModel.loadMorePhotos()
                            }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var emptyState: some View {
        VStack {
            Spacer()
            Text(Constants.emptyState)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    var findPhotos: some View {
        VStack {
            Spacer()
            Text(Constants.homeSearch)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
