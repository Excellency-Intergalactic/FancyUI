//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 29/01/2022.
//

import SwiftUI
import PDFKit

struct DisplayPDFView: View {
    var pdf: PDFDocument
    
    var body: some View {
        PDFKitRepresentedView(pdf.dataRepresentation() ?? Data(), singlePage: (pdf.pageCount > 1) ? false : true)
    }
}

struct DisplayPDFView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPDFView(pdf: PDFDocument())
    }
}
