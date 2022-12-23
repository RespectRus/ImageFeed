//
//  ViewController.swift
//  ImageFeed
//
//  Created by Respect on 19.12.2022.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


extension ImagesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Этот метод отвечает за действия, которые будут выполнены при тапе по ячейке таблицы
    }
}

extension ImagesListViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //Для простоты пока будем возвращать, что в секции одна ячейка.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell() // дефолтный конструктор, который не принимает никаких аргументов
    }
    
    
}

