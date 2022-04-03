//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Kusanagi Shuichi on 2022/04/03.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
    
    
    //PostData.swiftの内容をセルに表示
    func setPostData(_ postData: PostData) {
        
        //画像の表示（Cloud Storageに保存されている画像をダウンロードして、それをpostImageViewに表示する）
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)

        //キャプションの表示（投稿者名 : キャプション情報）
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        //日時の表示（日時情報を文字列に変換する）
        self.dateLabel.text = ""
        if let date = postData.date {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
            
        }

        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        //いいねボタンの表示
        if postData.isLiked {
            
            //赤いハートマーク
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
            
        } else {
            
            //白抜きハートマーク
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
            
        }
    }
    
    
}
