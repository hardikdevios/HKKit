//
//  HKEmptyCell.swift
//  Genemedics
//
//  Created by Hardik on 10/10/16.
//  Copyright © 2016 Praxinfo. All rights reserved.
//

import UIKit

public class HKEmptyCell: UITableViewCell {

    @IBOutlet public weak var emotyView: HKEmptyView!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
