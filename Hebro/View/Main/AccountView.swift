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
    }
    

    
    var linksSection: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://www.linkedin.com/in/hodaya-rosenberg/")! ) {
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
            let url = URL(string: K.API.randomAddress)!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            address = Address(id: 1, country: "Error fetching")
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView( userName: $userName)
//    }
//}

struct Address: Identifiable, Decodable {
    var id: Int
    var country: String
}
