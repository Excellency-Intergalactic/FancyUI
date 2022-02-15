//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 14/02/2022.
//

import SwiftUI
import Quartz

struct ImagePicker<Content: View>: View {
    // Image
    @State private var showImagePicker = false
    #if os(iOS)
    @State private var inputImage: UIImage?
    #else
    @State private var inputImage: NSImage?
    #endif

    var showFilePicker: Bool?
    
    @Binding var ImageData: Data
    @Binding var image: Image
    
    @ViewBuilder var content: Content
    
    func save() {
        #if os(iOS)
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)

        ImageData = pickedImage ?? Data()
        image = Image(uiImage: UIImage(data: ImageData) ?? UIImage(imageLiteralResourceName: ""))
        #else
        let cgImage = inputImage?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let data = NSBitmapImageRep(cgImage: cgImage!)
        let binaryData = data.representation(using: .jpeg, properties: [:])

        ImageData = binaryData ?? Data()
        #endif
        
    }

    func loadImage() {
        #if os(iOS)
        image = Image(uiImage: UIImage(data: ImageData) ?? UIImage(imageLiteralResourceName: ""))
        #else
        image = SwiftUI.Image(nsImage: NSImage(data: ImageData) ?? NSImage(imageLiteralResourceName: "iOS Icon"))
        #endif
    }

    // MARK: - Body
    var body: some View {
        VStack {
            if !(showFilePicker ?? false) {
                Button {
                        #if os(iOS)
                        showImagePicker.toggle()
                        #else
                            let imageChooser: IKPictureTaker = IKPictureTaker.pictureTaker()
                            imageChooser.runModal()
                            if imageChooser.outputImage() != nil {
                                self.image = SwiftUI.Image(nsImage: imageChooser.outputImage())
                                inputImage = imageChooser.outputImage()
                                save()
                            }
                        #endif
                        } label: {
                            content
                        }.onAppear(perform: {
                        loadImage()
                    })
            #if os(iOS)
                .sheet(isPresented: $showImagePicker, onDismiss: save) { ImagePicker(image: self.$inputImage) }
#endif
            } else {
                FilePicker(types: [.png, .image, .rawImage, .jpeg], allowMultiple: false) {urls in
                    ImageData = urls.first?.dataRepresentation ?? Data()
                    loadImage()
                } label: {
                    content
                }
            }
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(showFilePicker: true, ImageData: .constant(Data()), image: .constant(Image(""))) {
            Text("Select Image")
        }
    }
}
