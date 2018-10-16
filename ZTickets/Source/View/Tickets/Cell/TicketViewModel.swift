//
//  TicketViewModel.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit

struct TicketViewModel {
    // MARK: - Properties
    
    var statusViewColor: UIColor?
    var subjectAttributedText: NSAttributedString?
    var statusAttributedText: NSAttributedString?
    var numberAttributedText: NSAttributedString?
    var descriptionAttributedText: NSAttributedString?
    
    // MARK: - Initializer
    
    init(model: Ticket) {
        subjectAttributedText = NSAttributedString(string: model.subject)
        numberAttributedText = NSAttributedString(string: String(model.id))
        descriptionAttributedText = NSAttributedString(string: model.description)
        
        if let status = Status(rawValue: model.status) {
            statusAttributedText = NSAttributedString(string: status.rawValue)
            
            switch status {
            case Status.new:
                statusViewColor = .green
            case Status.open:
                statusViewColor = .blue
            case Status.pending:
                statusViewColor = .yellow
            case Status.hold:
                statusViewColor = .orange
            case Status.solved:
                statusViewColor = .black
            case Status.closed:
                statusViewColor = .red
            }
        } else {
            statusAttributedText = NSAttributedString(string: "---")
            statusViewColor = .brown
        }
    }
}
