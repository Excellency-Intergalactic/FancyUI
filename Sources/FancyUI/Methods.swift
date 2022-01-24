//
//  File.swift
//  
//
//  Created by Luca on 24/01/2022.
//

import Foundation
import SwiftUI
import PDFKit

// create pdf

extension View {
    func createPDF(save: Bool) -> PDFPage {
        #if os(iOS)
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let image = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        #else
        let controller = NSHostingController(rootView: self)
        let targetSize = controller.view.intrinsicContentSize
        let contentRect = NSRect(origin: .zero, size: targetSize)
                
        let window = NSWindow(
                    contentRect: contentRect,
                    styleMask: [.borderless],
                    backing: .buffered,
                    defer: false
                )
        window.contentView = controller.view
                
        guard let bitmapRep = controller.view.bitmapImageRepForCachingDisplay(in: contentRect) else { return PDFPage() }
                
        controller.view.cacheDisplay(in: contentRect, to: bitmapRep)
        let image = NSImage(size: bitmapRep.size)
        image.addRepresentation(bitmapRep)
        #endif
        
        let pdf = PDFPage(image: image)
        return pdf ?? PDFPage()
    }
}

// create image

extension View {
    func createImage(save: Bool) -> Image {
        #if os(iOS)
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        let uiimage = renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        let image = Image(uiimage)
        #else
        let controller = NSHostingController(rootView: self)
        let targetSize = controller.view.intrinsicContentSize
        let contentRect = NSRect(origin: .zero, size: targetSize)
                
        let window = NSWindow(
                    contentRect: contentRect,
                    styleMask: [.borderless],
                    backing: .buffered,
                    defer: false
                )
        window.contentView = controller.view
                
        guard let bitmapRep = controller.view.bitmapImageRepForCachingDisplay(in: contentRect) else { return Image("") }
                
        controller.view.cacheDisplay(in: contentRect, to: bitmapRep)
        let nsimage = NSImage(size: bitmapRep.size)
        nsimage.addRepresentation(bitmapRep)
        let image = Image(nsImage: nsimage)
        #endif
        
        
        return image
    }
}

