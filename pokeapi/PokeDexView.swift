//
//  PokeDexView.swift
//  pokeapi
//
//  Created by Shreeram Kelkar on 13/11/23.
//

import SwiftUI
import Combine
import Alamofire

struct PokeDexView: View {
    @State var pokemonList = [Pokemon] ()
    @State var nextURL : String = ""
    @State private var currentPage = 1
    @State private var isLoading = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(pokemonList.indices,id: \.self) { i in
                    PokeCardView(pokemon: pokemonList[i])
                        .onAppear() {
                            fetchNext(index: i)
                        }
                }
            }
            
        }.task {
            await fetchData()
        }.background(Color.purple)
    }
    
    private func shouldLoadNextPage(index: Int) -> Bool {
        guard let lastPokemon = pokemonList.last else {
            return true
        }
        // Check if the last item is close to the end
        let lastIndex = pokemonList.count - 1
        return lastIndex == index && !isLoading && nextURL != ""
    }
    
    func fetchNext(index: Int) {
        if shouldLoadNextPage(index: index) {
            print("Shreeram \(nextURL)")
            self.isLoading = true
            _ = AF.request(URL(string: convertToHttps(urlString: self.nextURL)) ?? "")
                .validate()
                .responseDecodable(of: PokemonList.self) { response in
                    switch response.result {
                    case .success(let decodedData):
                        DispatchQueue.main.async {
                            pokemonList.append(contentsOf: decodedData.results)
                            self.nextURL = decodedData.next ?? ""
                        }
                    case .failure(_):
                        print("error")
                    }
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                }
        }
    }
    
    
    func fetchData() async {
        _ = AF.request("https://pokeapi.neopentane.xyz/api/v2/pokemon/?limit=20?offset=0")
            .validate()
            .responseDecodable(of: PokemonList.self) { response in
                switch response.result {
                case .success(let decodedData):
                    DispatchQueue.main.async {
                        pokemonList = decodedData.results
                        nextURL = decodedData.next ?? ""
                    }
                case .failure(_):
                    print("error")
                }
            }
    }
}

//#Preview {
//    PokeDexView()
//}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonList: Decodable {
    let next : String?
    let results: [Pokemon]
}


func getPokemonNumber(from urlString: String) -> String? {
    let pattern = "pokemon/(\\d+)/"
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: urlString.utf16.count)
        if let match = regex.firstMatch(in: urlString, options: [], range: range) {
            if let pokemonNumberRange = Range(match.range(at: 1), in: urlString),
               let pokemonNumber = Int(urlString[pokemonNumberRange]) {
                return String(pokemonNumber)
            }
        }
    } catch {
        print("Error creating regex: \(error.localizedDescription)")
    }
    return nil
}

func convertToHttps(urlString: String) -> String {
    guard var urlComponents = URLComponents(string: urlString) else {
        // Invalid URL string, return original string
        return urlString
    }
    
    // Change the scheme to "https"
    urlComponents.scheme = "https"
    
    // Return the new URL string
    return urlComponents.string ?? urlString
}
