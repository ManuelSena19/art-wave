import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utilities/show_error_dialog.dart';

Future<void> removeFollower(BuildContext context, String currentUserEmail,
    String userToUnfollowEmail) async {
  try {
    if (currentUserEmail == userToUnfollowEmail) {
      showErrorDialog(
          context, 'Error: Current user cannot unfollow themselves.');
      return;
    }

    DocumentReference currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserEmail);

    DocumentReference userToUnfollowRef =
        FirebaseFirestore.instance.collection('users').doc(userToUnfollowEmail);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot currentUserSnapshot =
          await transaction.get(currentUserRef);
      DocumentSnapshot userToUnfollowSnapshot =
          await transaction.get(userToUnfollowRef);

      Map<String, dynamic>? currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>?;
      Map<String, dynamic>? userToUnfollowData =
          userToUnfollowSnapshot.data() as Map<String, dynamic>?;

      if (currentUserData == null || userToUnfollowData == null) {
        showErrorDialog(context, 'Error: Invalid users.');
        return;
      }

      List<dynamic>? currentUserFollowing = currentUserData['followers'];
      List<dynamic>? userToUnfollowFollowers = userToUnfollowData['following'];

      if (currentUserFollowing == null || userToUnfollowFollowers == null) {
        showErrorDialog(context, 'Error: Invalid users.');
        return;
      }

      currentUserFollowing.remove(userToUnfollowEmail);
      currentUserData['followers'] = currentUserFollowing;

      userToUnfollowFollowers.remove(currentUserEmail);
      userToUnfollowData['following'] = userToUnfollowFollowers;

      transaction.update(currentUserRef, currentUserData);
      transaction.update(userToUnfollowRef, userToUnfollowData);
    });
  } catch (e) {
    showErrorDialog(context, 'Error removing follower: $e');
  }
}

Future<void> addFollower(BuildContext context, String currentUserEmail,
    String newFollowerEmail) async {
  try {
    if (currentUserEmail == newFollowerEmail) {
      showErrorDialog(context, 'Error: Current user cannot follow themselves.');
      return;
    }

    DocumentReference currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserEmail);

    DocumentReference newFollowerRef =
        FirebaseFirestore.instance.collection('users').doc(newFollowerEmail);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot currentUserSnapshot =
          await transaction.get(currentUserRef);
      DocumentSnapshot newFollowerSnapshot =
          await transaction.get(newFollowerRef);

      Map<String, dynamic>? currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>?;
      Map<String, dynamic>? newFollowerData =
          newFollowerSnapshot.data() as Map<String, dynamic>?;

      if (currentUserData == null) {
        currentUserData = {
          'followers': [newFollowerEmail]
        };
      } else {
        List<dynamic>? currentUserFollowing = currentUserData['followers'];

        if (currentUserFollowing == null) {
          currentUserFollowing = [newFollowerEmail];
        } else if (currentUserFollowing.contains(newFollowerEmail)) {
          showErrorDialog(context, 'Error: Double following not allowed.');
          return;
        } else {
          currentUserFollowing.add(newFollowerEmail);
        }

        currentUserData['followers'] = currentUserFollowing;
      }

      if (newFollowerData == null) {
        newFollowerData = {
          'following': [currentUserEmail]
        };
      } else {
        List<dynamic>? newFollowerFollowing = newFollowerData['following'];

        if (newFollowerFollowing == null) {
          newFollowerFollowing = [currentUserEmail];
        } else if (newFollowerFollowing.contains(currentUserEmail)) {
          showErrorDialog(context, 'Error: Double following not allowed.');
          return;
        } else {
          newFollowerFollowing.add(currentUserEmail);
        }

        newFollowerData['following'] = newFollowerFollowing;
      }

      transaction.update(currentUserRef, currentUserData);
      transaction.update(newFollowerRef, newFollowerData);
    });
  } catch (e) {
    showErrorDialog(context, 'Error adding follower: $e');
  }
}

Future<bool> isFollowing(String currentUserEmail, String otherUserEmail) async {
  try {
    if (currentUserEmail == otherUserEmail) {
      return false;
    }

    DocumentReference currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserEmail);

    DocumentSnapshot currentUserSnapshot = await currentUserRef.get();
    Map<String, dynamic>? data =
        currentUserSnapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return false;
    }

    List<dynamic>? followers = data['followers'];

    if (followers == null) {
      return false;
    }

    return followers.contains(otherUserEmail);
  } catch (e) {
    return false;
  }
}
