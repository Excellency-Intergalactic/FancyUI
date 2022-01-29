//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 29/01/2022.
//

import SwiftUI

import SwiftUI
import UniformTypeIdentifiers

public struct FilePicker<LabelView: View>: View {
    
    public typealias PickedURLsCompletionHandler = (_ urls: [URL]) -> Void
    public typealias LabelViewContent = () -> LabelView
    
    public let types: [UTType]
    public let allowMultiple: Bool
    public let pickedCompletionHandler: PickedURLsCompletionHandler
    public let labelViewContent: LabelViewContent
    
    public init(types: [UTType], allowMultiple: Bool, onPicked completionHandler: @escaping PickedURLsCompletionHandler, @ViewBuilder label labelViewContent: @escaping LabelViewContent) {
        self.types = types
        self.allowMultiple = allowMultiple
        self.pickedCompletionHandler = completionHandler
        self.labelViewContent = labelViewContent
    }

    public init(types: [UTType], allowMultiple: Bool, title: String, onPicked completionHandler: @escaping PickedURLsCompletionHandler) where LabelView == Text {
        self.init(types: types, allowMultiple: allowMultiple, onPicked: completionHandler) { Text(title) }
    }
    
    @State private var isPresented: Bool = false
    
    #if os(iOS)
    
    public var body: some View {
        Button {
                if !isPresented { isPresented = true }
            } label: {
                labelViewContent()
            }
        .disabled(isPresented)
        .sheet(isPresented: $isPresented) {
            FilePickerUIRepresentable(types: types, allowMultiple: allowMultiple, onPicked: pickedCompletionHandler)
        }
    }
    
    #else
    
    public var body: some View {
        Button {
                if !isPresented { isPresented = true }
            } label: {
                labelViewContent()
            }
        .disabled(isPresented)
        .onChange(of: isPresented, perform: { presented in
            // binding changed from false to true
            if presented == true {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = allowMultiple
                panel.canChooseDirectories = false
                panel.canChooseFiles = true
                panel.allowedFileTypes = types.map { $0.identifier }
                panel.begin { reponse in
                    if reponse == .OK {
                        pickedCompletionHandler(panel.urls)
                    }
                    isPresented = false
               }
            }
        })
    }
    #endif
    
}
