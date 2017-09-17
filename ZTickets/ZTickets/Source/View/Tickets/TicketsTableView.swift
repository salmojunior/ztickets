//
//  TicketsTableView.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit

class TicketsTableView: UITableView {
    // MARK: - Constants
    
    private let defaultCellHeight: CGFloat = 115
    
    // MARK: - Public Methods
    
    func initialSetup() {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = defaultCellHeight
        tableFooterView = UIView()
    }
}
