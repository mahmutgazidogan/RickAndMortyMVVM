//
//  RickAndMortyViewModel.swift
//  RickAndMortyWithoutSB
//
//  Created by Mahmut Gazi Doğan on 17.12.2022.
//

import Foundation

protocol IRickAndMortyViewModel {
    func fetchItems()
    func changeLoading()
    
    var rickAndMortyCharacters: [Result] { get set }
    var rickAndMortyService: IRickAndMortyService { get }
    var rickAndMortyOutput: RickAndMortyOutput? { get }
    
    func setDelegate(output: RickAndMortyOutput)
}

class RickAndMortyViewModel: IRickAndMortyViewModel {
    var rickAndMortyOutput: RickAndMortyOutput?
    
    func setDelegate(output: RickAndMortyOutput) {
        rickAndMortyOutput = output
    }
    
    
    var rickAndMortyCharacters: [Result] = []
    private var isLoading = false
    let rickAndMortyService: IRickAndMortyService
    
    init() {
        rickAndMortyService = RickAndMortyService()
    }
    
    func fetchItems() {
        changeLoading()
        rickAndMortyService.fetchAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickAndMortyCharacters = response ?? []
            self?.rickAndMortyOutput?.saveDatas()
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickAndMortyOutput?.changeLoading(isLoad: isLoading)
    }
    
}
