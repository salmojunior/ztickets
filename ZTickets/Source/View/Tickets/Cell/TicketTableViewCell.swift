//
//  TicketTableViewCell.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Constants
    
    static let identifier = "ticketCellIdentifier"
    
    // MARK: - Properties
    
    var viewModel: TicketViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Private Methods
    
    private func bindViewModel() {
        statusView.backgroundColor = viewModel?.statusViewColor
        subjectLabel.attributedText = viewModel?.subjectAttributedText
        statusLabel.attributedText = viewModel?.statusAttributedText
        numberLabel.attributedText = viewModel?.numberAttributedText
        descriptionLabel.attributedText = viewModel?.descriptionAttributedText
    }
}
