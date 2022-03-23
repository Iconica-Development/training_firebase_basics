# Authentication
---

### Firebase preparation
<img src="../images/firebase-auth-1.png">

---
<img src="../images/firebase-auth-2.png">

---
<img src="../images/firebase-auth-3.png">

---
### Pub.dev
- https://pub.dev/packages/firebase_auth/install

---
### Firebase Authentication for Flutter
<img src="../images/pubspec-auth.png">

---
### Code
<img src="../images/firebase-auth-code.png">

---
### Sign up
<img src="../images/firebase-auth-code-2.png">

---
### And now?
- Now we can sign in, so a user can authenticate itself.
- Authorization will be explained later.
- Doing something with an authenticated user...

---
### States - authStateChanges
<img src="../images/firebase-auth-state.png">

---
### States - idTokenChanges
<img src="../images/firebase-auth-token.png">

---
### States - userChanges
<img src="../images/firebase-auth-user.png" height=500>

---
### Persistence
- IOS & Android out of the box, can be cleared by clearing app data in device settings.
- On web persistence is stored in local storage and can be configured

```await FirebaseAuth.instance.setPersistence(Persistence.NONE);```

---
### Other sign in providers
- Lots of sign in providers available
- Need extra configuration for each provider
- On pub.dev there are packages for some providers or an own implementation can be realized

- When social sign is used, Apple requires you to implement Apple's own sign in process

```FirebaseAuth.instance.signInWithCredential(credential)```

---
### Example of sign in with Facebook
<img src="../images/facebook-sign-in.png">

---
### DIY
- Create a login screen
- Sign in with email and password
- Catch potential errors
- Optional: Sign up, password reset, stay signed in, styling, more sign-in providers etc.
