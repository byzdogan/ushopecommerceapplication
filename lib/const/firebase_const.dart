import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
//final User? user = authInstance.currentUser;
//final userID = user!.uid;

//This user will be initialized only once
// when the user open the app,
// it will not change on login or logout events.