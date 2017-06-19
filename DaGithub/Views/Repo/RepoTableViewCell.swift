//
//  TableViewCell.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material
import AlamofireImage
import Alamofire
import SwiftIconFont

class RepoTableViewCell: Material.TableViewCell {
    private var spacing: CGFloat = 10
    
    /// A boolean that indicates whether the cell is the last cell.
    public var isLast = false
    
    public lazy var card: PresenterCard = PresenterCard()
    
    /// Toolbar views.
    private var toolbar: Toolbar!
    private var moreButton: IconButton!
    
    /// Presenter area.
    private var presenterImageView: UIImageView!
    private var avatarImageView: UIImageView!
    
    /// Content area.
    private var contentLabel: UILabel!
    
    /// Bottom Bar views.
    private var bottomBar: Bar!
    private var dateFormatter: DateFormatter!
    private var dateLabel: UILabel!
    private var favoriteButton: IconButton!
    private var forkButton: IconButton!
    
    public var data: Repo? {
        didSet {
            layoutSubviews()
        }
    }
    
    /// Calculating dynamic height.
    open override var height: CGFloat {
        get {
            return card.height + spacing
        }
        set(value) {
            super.height = value
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let repo = data else {
            return
        }
        
        toolbar.title = repo.owner?.login ?? "No Name"
        toolbar.detail = repo.owner?.reposUrl
        
        if let avatarPath = repo.owner?.avatar_url, let avatarURL = URL(string: avatarPath) {
            
            let filter = AspectScaledToFillSizeFilter(size: CGSize(width: 22, height: 22))
            
            avatarImageView.af_setImage(withURL: avatarURL, placeholderImage: UIImage(), filter:filter, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true)
        }

        contentLabel.text = repo.description
        dateLabel.text =  dateFormatter.string(from: repo.createdDate!)
        favoriteButton.isSelected = false
        
        if DataManager.favorites.keys.contains(repo.id) {
            favoriteButton.isSelected = true
        }
        
        card.x = 0
        card.y = 0
        card.width = width
        
        card.setNeedsLayout()
        card.layoutIfNeeded()
    }
    
    open override func prepare() {
        super.prepare()
        
        //layer.rasterizationScale = Screen.scale
        //layer.shouldRasterize = true
        
        pulseAnimation = .none
        backgroundColor = nil
        
        prepareDateFormatter()
        prepareDateLabel()
        prepareMoreButton()
        prepareToolbar()
        prepareAvatarImageView()
        prepareFavoriteButton()
        prepareForkButton()
        preparePresenterImageView()
        prepareContentLabel()
        prepareBottomBar()
        preparePresenterCard()
    }
    
    private func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    private func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.textAlignment = .center
    }
    
    private func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical, tintColor: Color.blueGrey.base)
    }
    
    private func prepareFavoriteButton() {
        favoriteButton = IconButton(type: .custom)
        favoriteButton.tintColor = Color.red.base
        favoriteButton.setImage(Icon.favoriteBorder, for: .normal)
        favoriteButton.setImage(Icon.favorite, for: .selected)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(button:)), for: .touchUpInside)
    }
    
    private func prepareForkButton() {
        
        let icon = UIImage.icon(from: .Octicon, iconColor: Color.blueGrey.base, code: "git-branch", imageSize: CGSize(width:22,height:22), ofSize: 22)
        
        forkButton = IconButton(image: icon, tintColor: Color.blueGrey.base)
        forkButton.addTarget(self, action: #selector(forkButtonTapped), for: .touchUpInside)
    }
    
    private func prepareToolbar() {
        toolbar = Toolbar()
        toolbar.heightPreset = .xlarge
        toolbar.contentEdgeInsetsPreset = .square3
        toolbar.titleLabel.textAlignment = .left
        toolbar.detailLabel.textAlignment = .left
        toolbar.rightViews = [moreButton]
        toolbar.dividerColor = Color.grey.lighten3
        toolbar.dividerAlignment = .top
    }
    
    private func preparePresenterImageView() {
        presenterImageView = UIImageView()
        presenterImageView.contentMode = .scaleAspectFill
    }
    
    private func prepareAvatarImageView() {
        avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        //avatarImageView.frame.size = CGSize(width: 22, height: 22)
        //avatarImageView.clipsToBounds = true
        toolbar.leftViews = [avatarImageView]
    }
    
    private func prepareContentLabel() {
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = RobotoFont.regular(with: 14)
    }
    
    private func prepareBottomBar() {
        bottomBar = Bar()
        bottomBar.heightPreset = .xlarge
        bottomBar.contentEdgeInsetsPreset = .square3
        bottomBar.centerViews = [dateLabel]
        bottomBar.leftViews = [favoriteButton]
        bottomBar.rightViews = [forkButton]
        bottomBar.dividerColor = Color.grey.lighten3
    }
    
    private func preparePresenterCard() {
        card.toolbar = toolbar
        card.presenterView = presenterImageView
        card.contentView = contentLabel
        card.contentViewEdgeInsetsPreset = .square3
        card.contentViewEdgeInsets.bottom = 0
        card.bottomBar = bottomBar
        card.depthPreset = .none
        
        contentView.addSubview(card)
    }
}

extension RepoTableViewCell {
    @IBAction func favoriteButtonTapped(button:IconButton) {
        
        guard let repo = data else { return }
        
        let selected = !button.isSelected
        button.isSelected = selected
        
        if selected {
            DataManager.favorites[repo.id] = repo
        }else{
            DataManager.favorites.removeValue(forKey: repo.id)
        }
    }
    
    @IBAction func forkButtonTapped() {
        guard let sb = MainController.instance?.snackbarController else { return }
        sb.snackbar.text = "Fork not implemented yet..."
        sb.animate(snackbar: .visible)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            sb.animate(snackbar: .hidden)
        }
    }
}

