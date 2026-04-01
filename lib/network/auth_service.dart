import 'package:evently_c18/models/custom_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static Future<String?> login(String emailAddress, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // throw "x";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else if (e.code == "invalid-credential") {
        return "wrong email or password";
      }
      print('CODE:->${e.code}');

      return "${e.code.replaceAll("-", " ")}";
    } catch (e) {
      print("ERROR:->$e");
      return "something went wring";
    }
  }

  static Future<String?> register(CustomUserModel user, String password) async {
    try {
      UserCredential credintials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      user.uid = credintials.user!.uid;
      await createUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      print("CODE:->${e.code}");
      return (" ${e.code}");
    } catch (e) {
      print("ERROR:->$e");
      return ('$e');
    }
  }

  static Future<CustomUserModel?> getUser() async {
    CollectionReference<CustomUserModel> collection = _getUsersCollection();
    DocumentReference<CustomUserModel> doc = collection.doc(
      FirebaseAuth.instance.currentUser?.uid,
    );
    DocumentSnapshot<CustomUserModel> docSnapshot = await doc.get();
    print('----DONE---->${docSnapshot.data()}');
    return docSnapshot.data();
  }

  static Future createUser(CustomUserModel user) async {
    CollectionReference<CustomUserModel> collection = _getUsersCollection();

    DocumentReference doc = collection.doc(user.uid);
    await doc.set(user);
  }

  static CollectionReference<CustomUserModel> _getUsersCollection() {
    CollectionReference<CustomUserModel> collection = FirebaseFirestore.instance
        .collection("users")
        .withConverter<CustomUserModel>(
          fromFirestore: (snapshot, options) =>
              CustomUserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  forgotPAssword() {}
}
