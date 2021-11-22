//
//  ViewController.swift
//  CandidateDB
//
//  Created by Udagedara Dehigama on 2021/11/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
   
   

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var field: UITextField!
    var candidate = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.register(CandidateTableViewCell.nib(), forCellReuseIdentifier: CandidateTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateTableViewCell.identifier, for: indexPath) as! CandidateTableViewCell
        cell.configuration(with: candidate[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadCandidate()
         return true
    }
    func loadCandidate(){
        field.resignFirstResponder()
        guard let text = field.text,!text.isEmpty else{
            return}
        // Create check status for search
        let query = text
        
        
        candidate.removeAll()
        
     
        URLSession.shared.dataTask(with: URL(string: "https://randomuser.me/api/?results=50")!) { data, response, error in
            guard let data = data,error == nil else{return}
       
            //Convert
            var result: CandidateResult?
            do{
                result = try JSONDecoder().decode(CandidateResult.self, from: data)
            }
            catch{
                print("error")
            }
            guard let finalResult = result else{return}
            
            //Update our movies array
            let newCandidate = finalResult.results
            self.candidate.append(contentsOf: newCandidate)
            // Refresh our table
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
            
        }.resume()
    }
}
struct CandidateResult : Codable{
  
    let results:[Results]
   
}

struct Results: Codable {
    let name: Names
    let dob: Dob
    let picture: Picture
}
struct Names: Codable {
    let first: String
    let last: String
}
struct Dob: Codable {
    let age: Int
}
struct Picture: Codable {
    let thumbnail: String
}


