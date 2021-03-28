//
//  Service.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 30/11/2020.
//

import FirebaseAuth
import Firebase
import GoogleSignIn

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
typealias FirestoreCompletion = (Error?) -> Void

struct Service {
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUserWithFirebase(withEmail email: String, password: String, fullname: String, completion: @escaping(DatabaseCompletion)){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error, REF_USERS)
                return
            }
            guard let uid = result?.user.uid else { return }
            let values = ["email": email,
                          "fullname": fullname,
                          "hasSeenOnboarding": false] as [String : Any]
            
            REF_USERS.child(uid).updateChildValues(values,withCompletionBlock: completion)
        }
    }
    
    static func registerUserWithFireStore(withEmail email: String, password: String, fullname: String, completion: @escaping(FirestoreCompletion)) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            guard let uid = result?.user.uid else { return }
            let values = ["email": email,
                          "fullname": fullname,
                          "hasSeenOnboarding": false,
                          "uid": uid] as [String : Any]
            
            Firestore.firestore().collection("users").document(uid).setData(values, completion: completion)
        }
    }
    
    static func signInWithGoogle(didSignInFor user: GIDGoogleUser, completion: @escaping(DatabaseCompletion)){
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken:                   authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to sign in with google: \(error.localizedDescription)")
                completion(error, REF_USERS)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                if !snapshot.exists() {
                    print("DEBUG: user does not exist, create user")
                    guard let email = result?.user.email else { return }
                    guard let fullname = result?.user.displayName else { return }
                    
                    let values = ["email": email,
                                  "fullname": fullname,
                                  "hasSeenOnboarding": false] as [String : Any]
                    Firestore.firestore().collection("users").document(uid).setData(values)
                    REF_USERS.child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
                } else {
                    print("DEBUG: User already exist")
                    completion(error, REF_USERS.child(uid))
                }
            }
        }
    }
    
    static func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUserWithFirestore(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func updateUserHasSeenOnboarding(completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USERS.child(uid).child("hasSeenOnboarding").setValue(true, withCompletionBlock: completion)
    }
    
    static func updateUserHasSeenOnboardingFirestore(completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["hasSeenOnboarding": true]
        
        Firestore.firestore().collection("users").document(uid).updateData(data, completion: completion)
    }
    
    static func resetPassword(forEmail email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}

