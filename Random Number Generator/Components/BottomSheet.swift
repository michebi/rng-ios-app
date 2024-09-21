import SwiftUI
import UIKit

struct BottomSheet<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let content: Content
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented {
            if uiViewController.presentedViewController == nil {
                let hostingController = UIHostingController(rootView: BottomSheetContent(content: content))
                let sheetController = SheetViewController(hostingController: hostingController, isPresented: $isPresented)
                uiViewController.present(sheetController, animated: true)
            }
        } else {
            uiViewController.dismiss(animated: true)
        }
    }
}

struct BottomSheetContent<Content: View>: View {
    let content: Content
    
    var body: some View {
        ZStack {
            Color("surface-bg").edgesIgnoringSafeArea(.all)
            content
        }
    }
}

class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {
    let hostingController: UIHostingController<AnyView>
    @Binding var isPresented: Bool
    
    init<Content: View>(hostingController: UIHostingController<BottomSheetContent<Content>>, isPresented: Binding<Bool>) {
        self.hostingController = UIHostingController(rootView: AnyView(hostingController.rootView))
        self._isPresented = isPresented
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
        
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.delegate = self
        }
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        isPresented = false
    }
}

extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.background(
            BottomSheet(isPresented: isPresented, content: content())
        )
    }
}
