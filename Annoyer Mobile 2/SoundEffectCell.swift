//
//  SoundEffectCell.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/13/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit

class SoundEffectCell: UITableViewCell {

    @IBOutlet weak var soundText: UILabel!
    @IBOutlet weak var soundImage: UIImageView!
    
    var soundeffect:SoundEffect? {
        didSet {
            guard let soundeffect = soundeffect else {return}
            
            soundText.text = soundeffect.name
            soundImage.image = UIImage(named: soundeffect.image)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
