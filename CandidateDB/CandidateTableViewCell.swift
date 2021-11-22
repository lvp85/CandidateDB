//
//  CandidateTableViewCell.swift
//  CandidateDB
//
//  Created by Udagedara Dehigama on 2021/11/21.
//

import UIKit

class CandidateTableViewCell: UITableViewCell {

    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateOldLabel: UILabel!
    @IBOutlet weak var CandidateImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "CandidateTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "CandidateTableViewCell", bundle: nil)
    }
    func configuration(with model: Results){
        let name  = model.name.first+" "+model.name.last
        self.candidateName.text = name
        let age = model.dob.age
        self.candidateOldLabel.text = String(age)
        let url = model.picture.thumbnail
        if let data = try? Data(contentsOf: URL(string: url)!){
            self.CandidateImageView.image = UIImage(data: data)
        }
        
         
    }
}
