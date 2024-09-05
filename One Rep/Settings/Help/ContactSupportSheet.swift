//
//  ContactSupportSheet.swift
//  One Rep
//
//  Created by Dylan Ierugan on 8/14/24.
//

import SwiftUI
import MessageUI

struct ContactSupportSheet: View {
    
    // MARK: - Global Properties
    
    @EnvironmentObject var theme: ThemeModel
    
    // MARK: - Private Properties
    
    @State private var message = ""
    @State private var showingMail = false
    @State private var showError = false
    @State private var errorMessage = ""
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(theme.backgroundColor)
                    .ignoresSafeArea()
                VStack {
                    
                    if showError {
                        Text(ContactSupportStrings.NotSetUp.rawValue)
                            .customFont(size: .caption, weight: .semibold, design: .rounded)
                            .foregroundColor(.primary)
                            .padding(.top, 16)
                    }
                    
                    VStack {
                        HStack {
                            Text(HelpSectionStrings.SupportMessage.rawValue)
                                .customFont(size: .caption, weight: .semibold, design: .rounded)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 24)
                            Spacer()
                        }
                        
                        TextEditor(text: $message)
                            .scrollContentBackground(.hidden)
                            .background(.ultraThinMaterial)
                            .accentColor(Color(colorScheme == .dark ? theme.lightBaseColor : theme.darkBaseColor))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .frame(height: 400)
                            .customFont(size: .body, weight: .semibold, design: .rounded)
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                }
                .sheet(isPresented: $showingMail) {
                    MailComposeViewController(toRecipients: [ContactSupportStrings.DylanRecipient.rawValue,
                                                             ContactSupportStrings.TarekRecipient.rawValue], mailBody: message) {
                        dismiss()
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        Text(HelpSectionStrings.ContactSupport.rawValue)
                            .customFont(size: .body, weight: .bold, design: .rounded)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primary)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button  {
                            if MFMailComposeViewController.canSendMail() {
                                self.showingMail.toggle()
                            } else {
                                withAnimation {
                                    showError = true
                                }
                            }
                        } label: {
                            Image(systemName: Icons.PaperPlaneFill.rawValue)
                                .font(.caption.weight(.regular))
                                .foregroundColor(!message.isEmpty ? Color(colorScheme == .dark ? theme.lightBaseColor : theme.darkBaseColor): Color.secondary)
                                .padding(.leading, 8)
                        }
                    }
                })
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Functions
    
    private func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MARK: - Extension

struct MailComposeViewController: UIViewControllerRepresentable {
    
    var toRecipients: [String]
    var mailBody: String
    var didFinish: ()->()
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: true)
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailComposeViewController
        init(_ mailController: MailComposeViewController) {
            self.parent = mailController
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
    }
}
