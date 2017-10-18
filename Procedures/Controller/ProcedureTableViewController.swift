//
//  ProcedureTableViewController.swift
//  Procedures
//
//  Created by Arturs Derkintis on 17/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ProcedureTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = ProcedureTableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        viewModel.loadData()
    }

    private func setupObservers() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfType<Procedure>>(configureCell: { (dataSource, tableView, indexPath, procedure) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProcedureTableViewCell.cellID, for: indexPath) as? ProcedureTableViewCell else {
                return UITableViewCell()
            }
            cell.previewImageView.accessibilityLabel = procedure.icon
            ImageHelper.loadImage(url: procedure.icon, completion: { (image) in
                DispatchQueue.main.async {
                    if image?.accessibilityIdentifier == procedure.icon {
                        cell.previewImageView.image = image
                    }
                }
            })
            cell.nameLabel.text = procedure.name
            return cell
        })
        tableView.dataSource = nil
        let observable = viewModel.procedures.asObservable()
        observable.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ProcedureDetailsViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            let procedure = viewModel.procedure(indexPath: selectedIndexPath) {
            destinationViewController.viewModel.id = procedure.id
        }
    }
}
