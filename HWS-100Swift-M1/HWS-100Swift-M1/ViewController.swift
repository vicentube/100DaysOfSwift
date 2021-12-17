//
//  ViewController.swift
//  HWS-100Swift-M1
//
//  Created by Vicente on 16/12/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Flags"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                countries.append(item)
            }
        }
        countries.sort()
        print(countries)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlagRow", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.image = UIImage(named: countries[indexPath.row])
        cellConfig.imageProperties.maximumSize = CGSize(width: 60, height: 30)
        cellConfig.text = (countries[indexPath.row] as NSString).deletingPathExtension.uppercased()
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailFlag") as? DetailViewController {
            vc.selectedFlag = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

