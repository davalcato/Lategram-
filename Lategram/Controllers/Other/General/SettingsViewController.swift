//
//  SettingsViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//
import SafariServices
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
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            
            },
            
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            
            }
        ])
        
        data.append([
            SettingCellModel(title: "Terms Of Services") { [weak self] in
                self?.openURL(type: .terms)
            
            },
            
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            
            },
            
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            
            }
        ])
       
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
                
            }
        ])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String 
        switch type {
        case .terms: urlString = "https://www.gucci.com/us/en/st/legal-landing?gclid=Cj0KCQiAzsz-BRCCARIsANotFgMkzDpPVpTSk9_xl-1XE63ZqZgCGFiIrhs04N4GI6EzQwRhAWPvktcaAjmIEALw_wcB"
        case .privacy: urlString = "https://www.gucci.com/us/en/st/privacy-landing"
        case .help: urlString = "https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwiD3e2cjMftAhUxBX0KHXXoCTkYABACGgJwdg&ae=2&ohost=www.google.com&cid=CAESQeD2TPDJCERfocWNpVDT7ESEhhN8bNOVbP12az_rTDttosuV93U5xFjFbdEtZryMKkmppUKmj2cBjK8oVNeLBuw4&sig=AOD64_3PTMOU3s11cEAfMc1aAe_NEh5auA&q&adurl&ved=2ahUKEwjttuScjMftAhWEJDQIHVGODuQQ0Qx6BAgGEAE&dct=1"
   
            
        }
        
        guard let url = URL(string: urlString) else {
            return
            
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
        
    }
    
    private func didTapInviteFriends() {
        // Show share sheet to invite friends...
        
        
    }
    
    private func didTapSaveOriginalPosts() {
        
        
    }
    
    private func didTapLogOut() {
        // create action sheet here...
        let actionsheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        // add the two button for the action sheet...
        actionsheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Log Out",
                                            style: .destructive,
                                            handler: { _ in
                                                
            AuthManager.shared.logOut(completion: { success in
                                                    
                // If the signOut successfully we present the logIN screen...
                DispatchQueue.main.async {
                    if success {
                        // present log in...
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            
                            
                        }
                        
                    }
                    // Otherwise something went wrong...
                    else {
                        // error occurred...
                        fatalError("Could not log out user!!!")
                    }
                }
                
            })
        }))
        // So not to crash on the iPad...
        actionsheet.popoverPresentationController?.sourceView = tableView
        actionsheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionsheet, animated: true)
        
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
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // To handle once this is selected we will get the model...
        data[indexPath.section][indexPath.row].handler()
        
        // Handle cell selection here...
    }
    
}
