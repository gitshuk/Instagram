//
//  PostData.swift
//  Instagram
//
//  Created by Kusanagi Shuichi on 2022/04/03.
//

import UIKit
import Firebase

class PostData: NSObject {
    
    //投稿ID
    var id: String
    //投稿者名
    var name: String?
    //キャプション
    var caption: String?
    //日付
    var date: Date?
    //いいねした人のIDの配列
    var likes: [String] = []
    //自分がいいねしたかどうかのフラグ
    var isLiked: Bool = false

    init(document: QueryDocumentSnapshot) {
        
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            
            self.likes = likes
            
        }
        
        if let myid = Auth.auth().currentUser?.uid {
            
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
            
        }
        
    }
    
}
