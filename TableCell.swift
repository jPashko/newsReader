//
//  TableCell.swift
//  newsReaderJson
//
//  Created by Yulia Pashko on 05.12.16.
//  Copyright © 2016 Yulia Pashko. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
   // @IBOutlet weak var text: UILabel!
    @IBOutlet weak var textDesc: UILabel!
    
    @IBOutlet weak var author: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
