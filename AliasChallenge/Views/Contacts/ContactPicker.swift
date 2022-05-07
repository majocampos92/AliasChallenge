import Foundation
import UIKit
import SwiftUI
import Contacts
import ContactsUI

// MARK: - Protocols
protocol ContactPickerViewControllerDelegate: AnyObject {
    func contactPickerViewController(_ viewController: ContactPickerViewController)
    func contactPickerViewControllerDidCancel(_ viewController: ContactPickerViewController)
}

// MARK: - Implementations
final class ContactPickerViewController: UIViewController, CNContactPickerDelegate {
    var delegate: ContactPickerViewControllerDelegate?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.didTapAdd()
    }
    
    func didTapAdd() {
        let viewController = CNContactPickerViewController()
        viewController.delegate = self
        self.present(viewController, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true) {
            self.delegate?.contactPickerViewController(self)
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: false) {
            self.delegate?.contactPickerViewControllerDidCancel(self)
        }
    }
}

struct ContactPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ContactPickerViewController
    
    var dismiss: () -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: ContactPickerViewControllerDelegate {
        
        let contactPicker: ContactPicker
        
        init(_ contactPicker: ContactPicker) {
            self.contactPicker = contactPicker
        }
        
        func contactPickerViewController(_ viewController: ContactPickerViewController) {
            contactPicker.dismiss()
        }
        
        func contactPickerViewControllerDidCancel(_ viewController: ContactPickerViewController) {
            viewController.dismiss(animated: true)
            contactPicker.dismiss()
        }
    }
}

// MARK: - Extensions
extension UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> ContactPicker.UIViewControllerType {
        let picker = ContactPicker.UIViewControllerType()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: ContactPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<ContactPicker>) { }
}
