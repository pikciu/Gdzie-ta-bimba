//
//  GroupedDirectionsCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol GroupedDirectionsCellDelegate: class {
    func toggleFavorite(_ bollard: Bollard)
}

final class GroupedDirectionsCell: UITableViewCell {
    @IBOutlet fileprivate weak var directionsLabel: UILabel!
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    @IBOutlet fileprivate weak var stopPointNameLabel: UILabel!
    fileprivate let converter = FavoriteStateToImageConverter()
    
    fileprivate var bollard: Bollard!
    
    weak var delegate: GroupedDirectionsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    @IBAction fileprivate func toggleFavorite() {
        self.delegate?.toggleFavorite(self.bollard)
    }
    
    fileprivate func directionAttributedString(_ direction: Direction, appendSeperator: Bool) -> NSAttributedString {
        let directionDescription = "\(direction.description)\(appendSeperator ? "\u{00a0}\n" : String.empty)"
        let lineRange = (directionDescription as NSString).range(of: direction.line)
        let attributedString = AttributedTextBuilder(string: directionDescription as String)
            .setFont(UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium))
            .setColor(UIColor(color: .mainLight))
            .setFont(UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), textRange: lineRange)
            .setColor(UIColor(argbHex: 0xFF718EA6), textRange: lineRange)
            .attributedText
        return attributedString
    }
}

extension GroupedDirectionsCell: NibLoadableView {

}

extension GroupedDirectionsCell: Configurable {
	func configure(_ model: GroupedDirections) {
        self.bollard = model.bollard
        let attributedString = NSMutableAttributedString()
        let grouped = model.directions.categorise { $0.directionName }
        for (index, directions) in grouped.enumerated() {
            let lines = directions.value.map { $0.line }.joined(separator: ",\u{00a0}")
            let direction = Direction(directionName: directions.key, line: lines, returnVariant: true)
            let directionString = self.directionAttributedString(direction, appendSeperator: index < grouped.count - 1)
            attributedString.append(directionString)
        }
        self.directionsLabel.attributedText = attributedString
        
        self.favoriteButton.setImage(self.converter.convert(model.bollard), for: UIControlState())
        
        self.stopPointNameLabel.text = model.bollard.name
    }
}
