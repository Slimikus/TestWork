//
//  SecondViewController.swift
//  TestWork
//
//  Created by Андрей Маковецкий on 27.06.17.
//  Copyright © 2017 Андрей Маковецкий. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func deleteAllButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Attention!!!", message: "This will lead to the removal of the entire history!", preferredStyle: .alert)
        
        let alertOkAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(delete) -> Void in
            arrayAll.removeAll()
            self.tableView.reloadData()
            UserDefaults.standard.set(arrayAll, forKey: "arrayAll")
        })
        alertController.addAction(alertOkAction)
        let alertNoAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertNoAction)
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAll.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let cityLabel = cell.viewWithTag(101) as? UILabel {
            cityLabel.text = arrayAll[indexPath.row][3]
        }
        
        if let tempLabel = cell.viewWithTag(104) as? UILabel {
            tempLabel.text = arrayAll[indexPath.row][4]
        }
        
        if let latLabel = cell.viewWithTag(102) as? UILabel {
            latLabel.text = arrayAll[indexPath.row][1]
        }
        
        if let lonLabel = cell.viewWithTag(103) as? UILabel {
            lonLabel.text = arrayAll[indexPath.row][2]
        }
        
        if let weatherLabel = cell.viewWithTag(105) as? UILabel {
            weatherLabel.text = arrayAll[indexPath.row][5]
        }
        
        if let timeLabel = cell.viewWithTag(106) as? UILabel {
            timeLabel.text = arrayAll[indexPath.row][0]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrayAll.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(arrayAll, forKey: "arrayAll")
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let IndexPath = self.tableView.indexPathForSelectedRow {
                let destVC: DetailViewController = segue.destination as! DetailViewController
                destVC.arrayDetail = arrayAll[IndexPath.row]
            }
            
        }
    }
}
