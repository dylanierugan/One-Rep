import SwiftUI
import RealmSwift


struct OpenRealmView: View {
    
    @AutoOpen(appId: AppConstants.ID.description, timeout: 4000) var autoOpen
    
    @Environment(\.realmConfiguration) private var config
    @EnvironmentObject var viewRouter: ViewRouter
        
    @State var user: User

    // MARK: - View

    var body: some View {
        switch autoOpen {
        case .connecting:
            OneRepProgressView(text: ProgressText.Connecting.description)
        case .waitingForUser:
            OneRepProgressView(text: ProgressText.Login.description)
        case .open(let realm):
            TabHolderView()
                .environment(\.realm, realm)
        case .progress(_):
            OneRepProgressView(text: ProgressText.Downloading.description)
        case .error(_):
            OneRepProgressView(text: ProgressText.ErrorGoingToLogin.description)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        viewRouter.currentPage = .loginView
                    }
                }
        }
    }
}
