//
//  SettingsViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit

struct SettingCellModel {
    let title: String
    
    // handler is a closer that takes no parameter and is void...
    let handler: (() -> Void)

}

// made final some no one can subclass it...
/// View Controller to show user settings...
final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    // this function get calked after all the other subviews...
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        // weak self here so not to cause a memory leak...
        let section = [
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
                
            }
        ]
        data.append(section)
    }
    
    private func didTapLogOut() {
        
        
    }
    
 
}
// to comform to the delegate and datasource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // To handle once this is selected we will get the model...
        data[indexPath.section][indexPath.row].handler()
        
        // Handle cell selection here...
        
        
    }
    
}
