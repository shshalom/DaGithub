

import UIKit
import Material

public class RepoDetailesView:UIView {
    
    let repo:Repo?
    
    var avatarView:UIImageView!
    var forkLabel:UILabel!
    var starLabel:UILabel!
    var langLabel:UILabel!
    var nameLabel:UILabel!
    
    public init(repo:Repo?) {
       self.repo = repo
        super.init(frame: CGRect(x:0,y:0,width:200, height:140))
        prepare()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        
        prepareAvatarView()
        prepareStatsBar()
        prepareNameLabel()
        
    }
    
    fileprivate func prepareAvatarView() {
        avatarView = UIImageView()
        if let avatarPath = repo?.owner?.avatar_url, let url = URL(string:avatarPath) {
            avatarView.af_setImage(withURL: url) { [weak self] image in
                if let image = image.value {
                self?.avatarView.image = image.blur(radius: 1.5, tintColor:.clear, saturationDeltaFactor: 0.5)
                }
            }
            
        }
        avatarView.contentMode = .scaleAspectFill
    }
    
    fileprivate func prepareNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = RobotoFont.bold(with: 22)
        nameLabel.textColor = Color.blue.base
        nameLabel.textAlignment = .left
        nameLabel.text = repo?.owner?.login
        
        nameLabel.sizeToFit()
        nameLabel.frame.origin.y = 78
        nameLabel.layer.zPosition = 10
        addSubview(nameLabel)
    }
    
    fileprivate func prepareStatsBar() {
        forkLabel = UILabel()
        forkLabel.font = RobotoFont.regular(with: 14)
        forkLabel.textColor = .white
        forkLabel.backgroundColor = Color.blue.base
        forkLabel.textAlignment = .center
        forkLabel.text = "fa:code-fork Forks:\(repo!.forks)"
        
        forkLabel.parseIcon()
        
        starLabel = UILabel()
        starLabel.font = RobotoFont.regular(with: 14)
        starLabel.textColor = .white
        starLabel.backgroundColor = Color.blue.base
        starLabel.textAlignment = .center
        starLabel.text = "io:star Stars:\(repo!.stargazersCount)"
        
        starLabel.parseIcon()
        

        
        langLabel = UILabel()
        langLabel.font = RobotoFont.regular(with: 14)
        langLabel.textColor = .white
        langLabel.backgroundColor = Color.blue.base
        langLabel.textAlignment = .center
        langLabel.text = "fa:code \(String(describing: repo!.language ?? String("N/A")))"
        
        langLabel.parseIcon()

    }
    
   
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelWidth:CGFloat = self.width/3
        
        self.layout(avatarView).top().left().right().height(100)
        
        forkLabel.frame = CGRect(x: 0, y: 100, width:labelWidth, height: 40)
        starLabel.frame = CGRect(x: labelWidth, y: 100, width:labelWidth, height: 40)
        langLabel.frame = CGRect(x: -1 + labelWidth*2, y: 100, width:labelWidth, height: 40)
        
        self.addSubview(forkLabel)
        self.addSubview(starLabel)
        self.addSubview(langLabel)

        avatarView.width = self.width
    }
}


class RepoDetailesController: UIViewController {
    fileprivate var repo:Repo!
    fileprivate var card: PresenterCard!
    
    /// Conent area.
    fileprivate var presenterView: RepoDetailesView!
    fileprivate var contentView: UILabel!
    
    /// Bottom Bar views.
    fileprivate var bottomBar: Bar!
    fileprivate var dateFormatter: DateFormatter!
    fileprivate var dateLabel: UILabel!
    fileprivate var favoriteButton: IconButton!
    fileprivate var gitHomepageButton: IconButton!
    fileprivate var forkButton: IconButton!
    
    /// Toolbar views.
    fileprivate var toolbar: Toolbar!
    fileprivate var closeButton: IconButton!
    
    init(repo:Repo) {
        super.init(nibName: nil, bundle: nil)
        self.repo = repo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear// Color.grey.lighten5
        
        preparePresenterView()
        prepareDateFormatter()
        prepareDateLabel()
        prepareGitHomeButton()
        prepareFavoriteButton()
        prepareForkButton()
        prepareMoreButton()
        prepareToolbar()
        prepareContentView()
        prepareBottomBar()
        preparePresenterCard()
    }
}

extension RepoDetailesController {
    fileprivate func preparePresenterView() {
        presenterView = RepoDetailesView(repo:repo)
    }
    
    fileprivate func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    fileprivate func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.textAlignment = .center
        dateLabel.text = dateFormatter.string(from: repo.createdDate!)
    }
    
    fileprivate func prepareFavoriteButton() {
        
        favoriteButton = IconButton(type: .custom)
        favoriteButton.tintColor = Color.red.base
        favoriteButton.setImage(Icon.favoriteBorder, for: .normal)
        favoriteButton.setImage(Icon.favorite, for: .selected)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(button:)), for: .touchUpInside)
        
        if DataManager.favorites.keys.contains(repo.id) {
            favoriteButton.isSelected = true
        }
    }
    
    fileprivate func prepareForkButton() {
        let icon = UIImage.icon(from: .Octicon, iconColor: Color.blueGrey.base, code: "git-branch", imageSize: CGSize(width:22,height:22), ofSize: 22)
        forkButton = IconButton(image:icon , tintColor: Color.blueGrey.base)
        forkButton.addTarget(self, action: #selector(forkButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func prepareMoreButton() {
        closeButton = IconButton(image: Icon.cm.close, tintColor: Color.blueGrey.base)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func prepareGitHomeButton() {
        
        let icon = UIImage.icon(from: .FontAwesome, iconColor: Color.blueGrey.base, code: "external-link-square", imageSize: CGSize(width:22,height:22), ofSize: 22)
        
        gitHomepageButton = IconButton(image: icon, tintColor: Color.blueGrey.base)
        gitHomepageButton.addTarget(self, action: #selector(gitHomeButtonTapped), for: .touchUpInside)
    }
    
    fileprivate func prepareToolbar() {
        toolbar = Toolbar(rightViews: [closeButton])
        
        toolbar.title = repo.owner?.login
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = repo.fullName
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.blueGrey.base
    }
    
    fileprivate func prepareContentView() {
        contentView = UILabel()
        contentView.numberOfLines = 0
        contentView.text = repo.description ?? "No description"
        contentView.font = RobotoFont.regular(with: 14)
    }
    
    fileprivate func prepareBottomBar() {
        bottomBar = Bar(leftViews: [favoriteButton, gitHomepageButton], rightViews: [forkButton], centerViews: [dateLabel])
    }
    
    fileprivate func preparePresenterCard() {
        card = PresenterCard()
        
        card.toolbar = toolbar
        card.toolbarEdgeInsetsPreset = .wideRectangle2
        
        card.presenterView = presenterView
        
        card.contentView = contentView
        card.contentViewEdgeInsetsPreset = .square3
        
        card.bottomBar = bottomBar
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        
        view.layout(card).horizontally(left: 20, right: 20).center()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        card.presenterView?.width = size.width
        card.presenterView?.layoutSubviews()
    }
}

extension RepoDetailesController {
    @IBAction func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtonTapped(button:IconButton) {
        
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
    
    @IBAction func gitHomeButtonTapped() {
        let url = NSURL(string: repo.htmlUrl!)!
        UIApplication.shared.open(url as URL, options: [:]) { (Bool) in
            
        }
    }

}

