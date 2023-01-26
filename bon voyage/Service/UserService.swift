//
//  UserService.swift
//  bon voyage
//
//  Created by HardiBSalih on 18.01.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService {
  
  static let instance = UserService()
  private init() { }
  
  var user: User?
  let auth = Auth.auth()
  
  var stripeId: String {
      return user?.stripeId ?? ""
  }
  
  // This is a function to retrieve the currently logged in users data.
  // We first check to make sure there is a logged in user.
  // Then we create a Firestore reference for that user called `userRef`
  // Then we call getDocument
  func getCurrentUser(completion: @escaping () -> ()) {
      guard let user = auth.currentUser else { return }
      
      let userRef = Firestore.firestore().collection("users").document(user.uid)
      userRef.getDocument { (snap, error) in
          
          if let error = error {
              debugPrint(error.localizedDescription)
              return
          }
          
          guard let data = snap?.data() else { return }
          self.user = User.initFrom(data)
          completion()
      }
  }
}
