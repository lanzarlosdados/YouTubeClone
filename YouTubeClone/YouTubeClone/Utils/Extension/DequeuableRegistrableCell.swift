//
//  DequeuableRegistrableCell.swift
//  YouTubeClone
//
//  Created by fabian zarate on 21/03/2023.
//

import Foundation

import UIKit

protocol Identificable   { static var  identifier: String { get } }
protocol NibInstanciable { static func nib() -> UINib }

extension UICollectionViewCell : Identificable, NibInstanciable {}
extension UITableViewCell      : Identificable, NibInstanciable {}

extension Identificable {
    static var identifier: String { return String.init(describing: Self.self) }
}

extension NibInstanciable where Self: Identificable {
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    
    func register<T:UICollectionViewCell>(cellType:T.Type)  {

        self.register(cellType.nib(), forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeue<T:UICollectionViewCell>(cellType:T.Type, at indexPath:IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! T
    }
    
    func configure(delegate: UICollectionViewDelegateFlowLayout, dataSource: UICollectionViewDataSource, cells: [UICollectionViewCell.Type]) {
        self.delegate = delegate
        self.dataSource = dataSource
        
        for cell in cells {
            let nib = UINib(nibName: String(describing: cell.self), bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: String(describing: cell.self))
        }
    }
}

extension UITableView {
    
    func register<T:UITableViewCell>(cellType:T.Type)  {
        self.register(cellType.nib(), forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeue<T:UITableViewCell>(cellType:T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: cellType.identifier) as! T
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        return cell
    }
    
    public func registerFromClass<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: "\(T.self)")
        
    }
    
    func configure(delegate: UITableViewDelegate? = nil, dataSource: UITableViewDataSource? = nil, cells: [UITableViewCell.Type], showIndicators: Bool = false, refreshControlTarget: NSObject? = nil, refreshControlAction: Selector? = nil) {
        self.delegate = delegate
        self.dataSource = dataSource
        
        for cell in cells {
            let nib = UINib(nibName: String(describing: cell.self), bundle: nil)
            self.register(nib, forCellReuseIdentifier: String(describing: cell.self))
        }
        
        self.showsVerticalScrollIndicator   = showIndicators
        self.showsHorizontalScrollIndicator = showIndicators
        self.separatorStyle                 = .none
        self.contentInsetAdjustmentBehavior = .never
        
        if let target = refreshControlTarget,
           let action = refreshControlAction {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(target, action: action, for: .valueChanged)
            self.refreshControl = refreshControl
        }
    }
    
 
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T else {
            fatalError("Failed to dequeue footer view.")
        }
        return view
    }
    
}
