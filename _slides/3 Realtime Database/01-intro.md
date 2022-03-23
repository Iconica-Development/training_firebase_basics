# Realtime Database
---

### Features
- NoSQL
- Cloud hosted
- Eventually consistent
- Schemaless
- JSON


---
### Setup
<img src="../images/rtdb-setup-1.png">

---
### Setup (2)
<img src="../images/rtdb-setup-2.png">

---
### Setup (3)
Rules will be covered later
<img src="../images/rtdb-setup-3.png">

---
### Setup (4)
You might have to redownload and configure the configuration files for Android and IOS from the Firebase console, after that a Flutter clean should be enough
<img src="../images/rtdb-setup-4.png">
<img src="../images/rtdb-setup-5.png">

---
### Data types
- String
- boolean
- int
- double
- Map
- List

---
### Basic operations - Set
<img src="../images/rtdb-basic-set.png">

---
### Basic operations - Update
<img src="../images/rtdb-basic-update.png">

---
### Basic operations - Reading using get
When data is only needed one time
<img src="../images/rtdb-basic-get.png">

---
### Basic operations - Reading using once
When data is needed immediately without checking for changes on the server
once can be used to immediately get the data from local storage.
<img src="../images/rtbd-basic-once.png">

---
### Basic operations - Reading using onValue
Fires when changes to child nodes are detected
<img src="../images/rtdb-basic-onvalue.png">

---
### Problem?
- We have posts in our app, when the app starts we want to get all posts from the server after retrieving we only want to get added or changed posts.
<img src="../images/rtdb-child-nodes.png">

---
### Basic operations - Delete
<img src="../images/rtdb-basic-delete.png">

---
### Sorting
<img src="../images/rtdb-sort.png">

---
### Filtering
<img src="../images/rtdb-filtering.png" height=500>

---
### Transactions
When working with data that COULD be changed by another client, you can use transactions to ensure that your changes are atomic. 
Transactions can be used for lots of different things.

<img src="../images/rtdb-transaction.png" height=400>


---
### Offline
The Firebase realtime database works offline and online.

Persistence can be enabled using ```FirebaseDatabase.instance.setPersistenceEnabled(true);```


This is done by having a local copy on your device, the SDK makes sure that data is eventually synchronized with the server.
Potential conflicts will be solved by the SDK.

---
### JSON Flattening
Firebase Realtime Database allows nesting up to 32 levels deep.

But...
Security is done at node level, when a user has access to a node. He also has access to all child nodes.
And when fetching data at a node, all child nodes will be included.

Therefore, an as flat as possible JSON structure is recommended!

---
### Example bad JSON
<img src="../images/rtdb-data-structure-bad.png">

---
### Example Good JSON
<img src="../images/rtdb-data-structure-good.png" height=500>

---
### Scaling
Sometimes two-way relationship between two nodes is needed, Especially when you have a lot of data.

<img src="../images/rtdb-scaling.png" height=400>

---
### DIY
- Create your own data structure for your app and implement it!
- Transactions and offline support are optional

