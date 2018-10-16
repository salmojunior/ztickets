//
//  TicketsTableViewController.swift
//  ZTickets
//
//  Created by Guest User on 9/16/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit

class TicketsTableViewController: UITableViewController, ViewCustomizable {
    // MARK: - Constants
    
    private let viewId = 39551161
    
    // MARK: - Properties
    
    typealias MainView = TicketsTableView
    fileprivate var tickets = [TicketViewModel]() {
        didSet {
            mainView.reloadData()
        }
    }
    private lazy var business: TicketsBusiness = {
        return TicketsBusiness()
    }()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizableStrings.ticketsTitle.localize()
        mainView.initialSetup()
        loadTickets()
    }
    
    // MARK: - Private methods
    
    private func loadTickets() {
        business.tickets(viewId: viewId) { [unowned self] (result) in
            do {
                let response = try result()
                
                self.tickets = response.map { TicketViewModel(model: $0) }
            } catch {
                self.title = error.localizedDescription
            }
        }
    }
}

// MARK: - Table view data source

extension TicketsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TicketTableViewCell.identifier, for: indexPath)

        if let ticketCell = cell as? TicketTableViewCell {
            ticketCell.viewModel = tickets[indexPath.row]
        }

        return cell
    }
}
