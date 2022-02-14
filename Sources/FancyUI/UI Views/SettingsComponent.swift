//
//  SwiftUIView.swift
//  
//
//  Created by Luca on 31/01/2022.
//

import SwiftUI

struct SettingsComponent<Content> : View where Content : View {
    @State var showingSheet = false
    var privacypolicy: String?
    var eula: String?
    var imageName: String?
    
    @ViewBuilder var generalSettings: () -> Content
    
    var body: some View {
            List {
                generalSettings()
                
                // Legal
                
                    DisclosureSection {
                        VStack {
                        WebView(url: privacypolicy ?? "https://excellency.one/legal/PrivacyPolicy.pdf")
                            .cornerRadius(25)
                        }
                            .frame(height: 500)
                            .contextMenu {
                                Button {
                                    showingSheet.toggle()
                                } label: {
                                    Label("Open in Full View", systemImage: "arrow.up.left.and.arrow.down.right")
                                }
                            }
                            .sheet(isPresented: $showingSheet, content: {WebView(url: privacypolicy ?? "https://excellency.one/legal/PrivacyPolicy.pdf", sheet: true)} )
                    } label: {
                        if #available(iOS 15.0, macOS 12.0, *) {
                            Label("Privacy Policy", systemImage: "person.crop.circle.badge.questionmark.fill")
                                .symbolRenderingMode(.multicolor)
                                .imageScale(.large)
                        } else {
                            Label("Privacy Policy", systemImage: "person.crop.circle.badge.questionmark.fill")
                                .imageScale(.large)
                        }
                    }
                    DisclosureSection {
                        VStack(alignment: .leading) {
                            VStack {
                            WebView(url: eula ?? "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")
                                .cornerRadius(25)
                            }
                            .frame(height: 500)
                            .contextMenu {
                                Button {
                                    showingSheet.toggle()
                                } label: {
                                    Label("Open in Full View", systemImage: "arrow.up.left.and.arrow.down.right")
                                }
                            }
                            .sheet(isPresented: $showingSheet, content: {WebView(url: eula ?? "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/", sheet: true)} )
                        }
                    } label: {
                        if #available(iOS 15.0, macOS 12.0, *) {
                            Label("End-User License Agreement", systemImage: "building.columns")
                                .symbolRenderingMode(.multicolor)
                                .imageScale(.large)
                        } else {
                            Label("End-User License Agreement", systemImage: "building.columns")
                                .imageScale(.large)
                        }
                    }
                // Copyright
                VStack(alignment: .center) {
                        Label("\(yearFormatter.string(from: Date())) Excellency Intergalactic. \nAll rights reserved.", systemImage: "c.circle")
                        .font(.headline.bold())
                        .foregroundColor(.primary)
                    Divider()
                                        Image(imageName ?? "Excellency Software")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 200)
                                            .padding(10)
                                            .background(Color.black)
                                            .cornerRadius(25)
                                            
                                    }
                
            }
        #if os(macOS)
            .padding()
        #endif
            .navigationTitle("Settings")
    }
}

struct SettingsComponent_Previews: PreviewProvider {
    static var previews: some View {
        SettingsComponent {
            Section {
                
            }
        }
    }
}
