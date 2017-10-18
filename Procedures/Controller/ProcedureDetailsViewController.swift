//
//  ProcedureDetailsViewController.swift
//  Procedures
//
//  Created by Arturs Derkintis on 18/10/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ProcedureDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    /// View Model
    public let viewModel = ProcedureDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        viewModel.loadData()
        viewModel.procedureDetails.asObservable().subscribe { [weak self] _ in
            guard let procedureDetails = self?.viewModel.procedureDetailsById() else {
                return
            }
            ImageHelper.loadImage(url: procedureDetails.card, completion: { (image) in
                DispatchQueue.main.async {
                    self?.cardImageView.image = image
                }
            })
            DispatchQueue.main.async {
                self?.nameLabel.text = procedureDetails.name
            }
        }.disposed(by: disposeBag)
    }

    ///////////////////////////////////////////////////////////
    ///     COMMENT FOR REVIEWERS OF THIS TEST PROJECT      ///
    /// Since it was stated that I should use RxSwift       ///
    /// I decided to also use RxDataSources which makes     ///
    /// the TableView dataSource implementation very handy  ///
    ///////////////////////////////////////////////////////////
    private func setupObservers() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfType<Phase>>(
            configureCell: { (dataSource, tableView, indexPath, phase) -> UITableViewCell in

            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProcedureTableViewCell.cellID, for: indexPath) as? ProcedureTableViewCell else {
                return UITableViewCell()
            }
            cell.previewImageView.accessibilityLabel = phase.icon
            ImageHelper.loadImage(url: phase.icon, completion: { (image) in
                DispatchQueue.main.async {
                    if image?.accessibilityIdentifier == phase.icon {
                        cell.previewImageView.image = image
                    }
                }
            })
            cell.nameLabel.text = phase.name
            return cell
        })
        let observable = viewModel.phases.asObservable()
        observable.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

}

// MARK: - UITableViewDelegate
extension ProcedureDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
