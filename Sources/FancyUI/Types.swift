//
//  File.swift
//  
//
//  Created by Luca on 05.12.21.
//

import Foundation
import SwiftUI
import PDFKit

public enum expandSymbol: String {
    // Chevrons
    case chevron = "chevron.right"
    case chevronCircle = "chevron.right.circle"
    case chevronCircleFilled = "chevron.right.circle.fill"
    case chevronSquare = "chevron.right.square"
    case chevronSquareFilled = "chevron.right.square.fill"
    case chevron2 = "chevron.forward.2"
    case chevronCompact = "chevron.compact.right"
    // Arrows
    case arrow = "arrow.right"
    case arrowCirlce = "arrow.up.circle"
    case arrowCircleFilled = "arrow.up.circle.fill"
    case arrowSquare = "arrow.right.square"
    case arrowSquareFilled = "arrow.right.square.fill"
    
    case arrowshape = "arrowshape.turn.up.right"
    case arrowshapeFill = "arrowshape.turn.up.right.fill"
    case arrowshapeCircle = "arrowshape.turn.up.right.circle"
    case arrowshapeCircleFill = "arrowshape.turn.up.right.circle.fill"
    
    case arrowtriangle = "arrowtriangle.right"
    case arrowtriangleFill = "arrowtriangle.right.fill"
    case arrowtriangleCirlce = "arrowtriangle.right.circle"
    case arrowtriangleCircleFilled = "arrowtriangle.right.circle.fill"
    case arrowtriangleSquare = "arrowtriangle.right.square"
    case arrowtriangleSquareFilled = "arrowtriangle.right.square.fill"
}

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
