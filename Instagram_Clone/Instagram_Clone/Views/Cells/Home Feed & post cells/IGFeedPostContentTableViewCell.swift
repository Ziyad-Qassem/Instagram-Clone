//
//  IGFeedPostTableViewCell.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//
import Kingfisher
import UIKit
import AVFoundation

class IGFeedPostContentTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostContentTableViewCell"
    
    private var player :  AVPlayer?
    private var postVideoPlayerLayer =  AVPlayerLayer()
    
    private  let postContentImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = nil
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(postVideoPlayerLayer)
        contentView.addSubview(postContentImageView)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCellSubViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post : UserPost){
        switch post.postType {
        case .photo:
            postContentImageView.kf.setImage(with: post.postURL)
        case .video:
            player = AVPlayer(url: post.postURL)
            postVideoPlayerLayer.player = player
            postVideoPlayerLayer.player?.volume = 0
            postVideoPlayerLayer.player?.play()
        }
    }
    override func prepareForReuse() {
        postContentImageView.image = nil
        postVideoPlayerLayer.player = nil
    }
    private func configureCellSubViews(){
        postContentImageView.frame = contentView.bounds
        postVideoPlayerLayer.frame = contentView.bounds
    }
}
