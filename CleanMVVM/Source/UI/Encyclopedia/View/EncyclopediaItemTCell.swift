//
//  EncyclopediaItemTCell.swift
//  CleanMVVM
//
//  Created by Tom on 2021/12/30.
//

import UIKit

final class EncyclopediaItemTCell: BaseTableViewCell {
  let titleLabel: UILabel = .init().then {
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = .defaultText
  }
  
  override func initialize() {
    self.contentView.backgroundColor = .background
    self.contentView.addSubview(self.titleLabel)
  }
  
  override func setupConstraints() {
    self.titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.top.bottom.equalToSuperview().inset(32)
    }
  }
  
  func configure(title: String) {
    self.titleLabel.text = title
  }
}
