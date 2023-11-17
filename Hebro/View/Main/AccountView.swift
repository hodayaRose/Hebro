//
//  AccountView.swift
//  AccountView
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import SwiftUI

struct AccountView: View {
    @State var isPinned = false
    @State var isDeleted = false
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLiteMode") var isLiteMode = true
    @EnvironmentObject var welcomViewManager : WelcomeViewManager
    @State var address: Address = Address(id: 1, country: "New York")
    @EnvironmentObject var databaseService : DatabaseManager
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                List {
                    Section {
                        profile
                    }
                    
                    Section {
                        
                        NavigationLink {} label: {
                            Label("Settings", systemImage: "gear")
                        }
                        
                        NavigationLink {} label: {
                            Label("Billing", systemImage: "creditcard")
                        }
                        
                        NavigationLink {} label: {
                            Label("Help", systemImage: "questionmark.circle")
                        }
                    }
                    .foregroundColor(.black.opacity(0.75))
                    .listRowSeparator(.automatic)
                    
                    Section {
                        Toggle(isOn: $isLiteMode) {
                            Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                                .tint(.black.opacity(0.75))
                                .foregroundColor(.black.opacity(0.75))
                        }
                    }
                    
                    linksSection
                    
                    
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Account")
                .task {
                    //fetches a random address
                    await fetchAddress()
                    
                }
                .refreshable {
                    //when refresh fetches another random address
                    await fetchAddress()
                    
                }
            }
            // Apply rotation if needed for landscape mode
                        .rotationEffect(.init(degrees: isLandscape(geometry) ? -90 : 0))
            // Swap width and height if in landscape mode
            .frame(width: isLandscape(geometry) ? geometry.size.height : geometry.size.width,
                   height: isLandscape(geometry) ? geometry.size.width : geometry.size.height)
        }
        
    }
    

    
    var linksSection: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: S.API.linkedIn)! ) {
                    HStack {
                        Label("Website", systemImage: "house")
                            .tint(.black.opacity(0.75))
                            .foregroundColor(.black.opacity(0.75))
                        Spacer()
                        Image(systemName: "link")
                            .tint(.gray)
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        withAnimation {
                            isPinned.toggle()
                        }
                    } label: {
                        if isPinned {
                            Label("Unpin", systemImage: "pin.slash")
                        } else {
                            Label("Pin", systemImage: "pin")
                        }
                    }
                    .tint(isPinned ? .gray : .yellow)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        withAnimation {
                            isDeleted.toggle()
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
            
        
        }
        .listRowSeparator(.automatic)
    }
    
    var profile: some View {
        VStack {
            Image("Avatar\(welcomViewManager.avatarIndex)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40,height: 40)
                .symbolVariant(.circle.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.gray, .gray.opacity(0.3), .red)
                .font(.system(size: 32))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
//
            Text("\(databaseService.userName)")//UPDATE TO NAME
                .font(.title.weight(.semibold))
            Text(address.country)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    func fetchAddress() async {
        do {
            let url = URL(string: S.API.randomAddress)!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            address = Address(id: 1, country: "Error fetching")
        }
    }
}
/// Function to determine if the device is in landscape mode 
 func isLandscape(_ geometry: GeometryProxy) -> Bool {
    geometry.size.width > geometry.size.height
}



