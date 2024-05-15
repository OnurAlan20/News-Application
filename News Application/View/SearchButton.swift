//
//  File.swift
//  News Application
//
//  Created by Onur Alan on 12.05.2024.
//

import UIKit

class SearchButton: UIButton {
    typealias TapAction = () -> Void

    var tapAction: TapAction?

    init() {
        super.init(frame: .zero)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        tintColor = .gray
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func buttonTapped() {
        tapAction?()
    }
}
