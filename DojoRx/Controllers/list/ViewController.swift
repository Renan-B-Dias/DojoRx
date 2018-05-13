//
//  ViewController.swift
//  DojoRx
//
//  Created by Renan Benatti Dias on 05/03/18.
//  Copyright © 2018 Blue Origami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let network = Network()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func configureTableView() {
        navigationItem.title = "Disney Characters"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UINib(nibName: DisneyCharacterCell.identifier, bundle: nil), forCellReuseIdentifier: DisneyCharacterCell.identifier)
    }
    
    private func bind() {
        network.getCharacters()
            .bind(to: tableView.rx.items(cellIdentifier: DisneyCharacterCell.identifier, cellType: DisneyCharacterCell.self)) { (row, disneyCharacter, cell) in
                cell.viewModel = DisneyCharacterCellViewModel(disneyCharacter: disneyCharacter)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind { self.tableView.deselectRow(at: $0, animated: true) }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(DisneyCharacter.self)
            .subscribe { (event) in
                switch event {
                case .next(let disneyCharacter):
                    let detailsViewController = DisneyDetailsViewController()
                    detailsViewController.characterViewModel = DisneyDetailsViewControllerViewModel(character: disneyCharacter)
                    let navigationController = UINavigationController(rootViewController: detailsViewController)
                    self.present(navigationController, animated: true)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("Did complete")
                }
            }
            .disposed(by: disposeBag)
    }
}

//        network.getCharacters()
//            .bind(to: tableView.rx.items(cellIdentifier: DisneyCharacterCell.identifier, cellType: DisneyCharacterCell.self)) { (row, disneyCharacter, cell) in
//                cell.populateWith(viewModel: DisneyCharacterCellViewModel(disneyCharacter: disneyCharacter))
//            }
//            .disposed(by: disposeBag)

// Each separate event
//        tableView.rx
//            .modelSelected(DisneyCharacter.self)
//            .subscribe(onNext: { (disneyCharacter) in
//                print("Did tap on \(disneyCharacter)")
//            }, onError: { (error) in
//                print(error.localizedDescription)
//            }, onCompleted: {
//                print("Did complete")
//            }, onDisposed: {
//                print("Did dispose")
//            })
//            .disposed(by: disposeBag)

// Only on Next (ignoring the rest)
//        tableView.rx
//            .modelSelected(DisneyCharacter.self)
//            .subscribe(onNext: { (disneyCharacter) in
//                print("Did tap \(disneyCharacter.name)")
//            })
//            .disposed(by: disposeBag)

// Explain it only accespts onNext
//        tableView.rx
//            .modelSelected(DisneyCharacter.self)
//            .bind { (disneyCharacter) in
//                print("Did tap on \(disneyCharacter.name)")
//            }
//            .disposed(by: disposeBag)
