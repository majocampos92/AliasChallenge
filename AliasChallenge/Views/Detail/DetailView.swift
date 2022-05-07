import SwiftUI
import Kingfisher

struct DetailView: View {
// MARK: - Parameters
    @StateObject var viewModel: DetailViewModel = .make()
    @Environment(\.openURL) var openURL
    
    let id: String
    let photo: String?
// MARK: - Body
    var body: some View {
        GeometryReader { geometry in

            ZStack(alignment: .bottomLeading) {

                let imageURL = URL(string: photo ?? Constants.empty)
                
                KFImage(imageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)

                VStack(alignment: .leading) {
                    
                    Button("\(Constants.buttonLinkLabel)") {
                        openURL(URL(string: photo ?? Constants.empty)!)
                    }
                    .padding(Constants.padding)
                    .background(.gray.opacity(Constants.opacityButton))
                    .clipShape(Rectangle())
                    .cornerRadius(Constants.cornerRadius)
                    
                    Text("\(Constants.owner): \(viewModel.photo?.name ?? Constants.notFound)")
                    Text("\(Constants.takenAt): \(viewModel.photo?.date ?? Constants.notFound)")
                    Text("\(viewModel.photo?.description ?? Constants.notFound)")
                }
                .lineLimit(Constants.lineLimit)
                .padding()
                .foregroundColor(.white)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height / CGFloat(Constants.heightButtomSheet),
                    alignment: .leading
                )
                .background(.black.opacity(Constants.opacityButtomSheet))
            }
        }
        .onAppear {
            viewModel.getDetailPhoto(id: id)
        }
        .navigationBarTitle(Constants.homeTitle, displayMode: .inline)
    }
}
