import SwiftUI

struct Search: View {
// MARK: - Parameters
    @Binding var searchText: String
    @State var showPicker = false
    let viewModel: HomeViewModel
    var dismiss: () -> Void
    
// MARK: - Body
    var body: some View {
        ZStack {
            HStack {
                
                Image(systemName: "person.crop.square.fill")
                    .onTapGesture {
                        self.showPicker.toggle()
                    }
                    .sheet(isPresented: $showPicker, content: {
                        ContactPicker(dismiss: dismiss)
                    })

                ZStack(alignment: .leading) {
                    TextField(Constants.searchInput, text: $searchText)
                }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        viewModel.contact = searchText
                        viewModel.reload()
                }
            }
            .foregroundColor(.black)
            .padding(Constants.padding)
        }
        .overlay(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.black, lineWidth: CGFloat(Constants.lineLimit))
        )
        .padding()
    }
}
