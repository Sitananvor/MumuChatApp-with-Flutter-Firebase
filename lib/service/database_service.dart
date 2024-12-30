import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseService {
  final String?
      uid; //uid keep User ID of each user, uid = nullable (String?) bc. the value may not be received when called.
  DatabaseService(
      {this.uid}); //Create an instance & {} allows to pass or not pass the uid value (Optional Parameter)

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    // doc(uid) : This document will be stored based on the user-specified uid, and is don't havr this uid >> create new gocument
    // set({}) : to create or write new data to a document.
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot = await userCollection
        .where("email", isEqualTo: email)
        .get(); //where("email", isEqualTo: email) to find documents in the user collection where the "email" field matches the specified email value.
    return snapshot;
  }

  Future gettingUserUid() async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    return snapshot['uid'];
  }

  // upload picture profile
  Future<void> uploadProfilePicture(File profileImage) async {
    try {
    // 1. get a referennce to storage root
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'profilePic/${DateTime.now().millisecondsSinceEpoch}.jpg');
    // 2. upload picture profile into Firebase Storage
    await storageReference.putFile(profileImage).whenComplete(() {});
    // 3. get URL of file from Firebase Storage;
    String? profileImageUrl = await storageReference.getDownloadURL();
    // // 4. keep/update URL of picture in Firestore
    // await FirebaseFirestore.instance.collection('user').doc(uid).update({
      // 'profilePic': profileImageUrl,});
   } catch (e) {
    print("Error uploading profile picture: $e");
  }
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      //Create a New Group Document
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the members >> Update the Group Document
    await groupDocumentReference.update({
      //FieldValue.arrayUnion:  Update a value in array (if value is already present, it will not be added again)
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
      //Update Document ID from Auto-generated ID Firebase: When adding a document (add({...})), Firestore does not generate the documentId until the addition is complete.
      //So a separate update() must be used to set the groupId field with the value of groupDocumentReference.id after the document has been created.
    });
    //Update the User's Document
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

// getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("message")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re-join
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$groupName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$groupName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("message").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
