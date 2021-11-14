//
//  BeerListTableViewCell.swift
//  Best Beer
//
//  Created by Pyramid on 13/11/21.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var abvLbl: UILabel!
    @IBOutlet weak var tagValLbl: UILabel!
    @IBOutlet weak var beerNameLbl: UILabel!
    @IBOutlet weak var beerImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDesignStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDesignStyle()
    {
        CSS.customLabel(beerNameLbl, textColor: .black)
        CSS.customLabel(tagValLbl, textColor: .gray)
        CSS.customLabel(abvLbl, textColor: .lightGray)
        CSS.customCardView(outerView, Bgcolor: UIColor(red:225/255, green:226/255, blue:235/255, alpha:1.0))
        beerNameLbl.backgroundColor = UIColor(red:225/255, green:226/255, blue:235/255, alpha:1.0)
        abvLbl.backgroundColor = UIColor(red:225/255, green:226/255, blue:235/255, alpha:1.0)
        tagValLbl.backgroundColor = UIColor(red:225/255, green:226/255, blue:235/255, alpha:1.0)
    }
}
