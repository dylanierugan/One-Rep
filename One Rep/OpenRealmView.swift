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
            VStack {
                OneRepProgressView(text: "")
                OneRepLogo(size: .body)
            }
        case .waitingForUser:
            VStack {
                OneRepProgressView(text: "")
                OneRepLogo(size: .body)
            }
        case .open(let realm):
            VStack {
                OneRepProgressView(text: "")
                OneRepLogo(size: .body)
            }
            .onAppear {
                viewRouter.realm = realm
                viewRouter.currentPage = .tabView
            }
        case .progress(_):
            VStack {
                OneRepProgressView(text: "")
                OneRepLogo(size: .body)
            }
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
