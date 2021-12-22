//
//  Reusable.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/22.
//

import UIKit

protocol ReusableView: AnyObject {
  static var id: String { get }
}

extension ReusableView where Self: UIView {
  static var id: String {
    return NSStringFromClass(self)
  }
}

extension UICollectionView {
  func register<T:UICollectionViewCell>(_:T.Type) where T: ReusableView {
    self.register(T.self, forCellWithReuseIdentifier: T.id)
  }
  
  func register<T: UICollectionReusableView>(_: T.Type, kind: String) where T: ReusableView {
    self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.id)
  }
  
  func dequeueCell<T: UICollectionViewCell>(ofType type : T.Type , indexPath : IndexPath) -> T where T: ReusableView {
    return dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as! T
  }
  
  func dequeueView<T: UICollectionReusableView>(ofType type: T.Type, kind: String, indexPath: IndexPath) -> T where T: ReusableView {
    return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.id, for: indexPath) as! T
  }
}

extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.id)
  }
  
  func dequeueCell<T: UITableViewCell>(ofType type:T.Type, indexPath:IndexPath) -> T where T: ReusableView  {
    return dequeueReusableCell(withIdentifier: T.id, for: indexPath) as! T
  }
}
