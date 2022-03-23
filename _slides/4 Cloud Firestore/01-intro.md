# Cloud Firestore
---

### Features
- NoSQL
- Cloud hosted
- Eventually consistent
- Schemaless
- Documents and collections

---
### Cloud Firestore vs Realtime Database
- Pro's
    - Security is made easier
    - The query language is more powerful
    - Multi-region support
    - Scaling is automatic (requires no sharding)

- Con's
    - Importing and exporting data is more difficult

---
### Setup
<img src="../images/cfs-setup-1.png">

---
### Setup (2)
<img src="../images/cfs-setup-2.png">

---
### Setup (3)
<img src="../images/cfs-setup-3.png">
<img src="../images/cfs-setup.png">

---
### Data types
- array
- boolean
- bytes
- date and time
- float
- geo point
- int
- map
- null
- string
- reference (document/collection)

---
### Basic operations - Add
<img src="../images/cfs-basic-add.png">

---
### Basic operations - Update
<img src="../images/cfs-basic-update.png">

---
### Basic operations - Get
<img src="../images/cfs-basic-get.png" height=500>

---
### Basic operations - Delete
<img src="../images/cfs-basic-delete.png">

---
### Basic operations - Listen
<img src="../images/cfs-basic-listen.png">
<img src="../images/cfs-basic-listen-2.png" height=400>

---
### QuerySnapshot 
- Returned from a query on a Collection

### DocumentSnapshot 
- Return from a query on a Document

---
### Filtering
<img src="../images/cfs-filtering-1.png">
<img src="../images/cfs-filtering-2.png">

---
### Limiting
<img src="../images/cfs-limit-1.png">
<img src="../images/cfs-limit-2.png">

---
### Ordering
<img src="../images/cfs-ordering.png">

---
### Cursors
<img src="../images/cfs-cursors-1.png">
<img src="../images/cfs-cursors-2.png">

---
### Limitations
- Range filters on multiple fields
- Logical OR queries
- Not equal queries (can be achieved by using greater than and less than together)

---
### Converters
Firestore references manipulate a ```Map<String, dynamic>``` by default. For this reason we lose type safety
Using a converter we can convert the Map to a specific type and get type safety back

<img src="../images/cfs-converters-1.png" height=200>
<img src="../images/cfs-converters-2.png" width=600>

This manipulates the behavior of the query talked about.

<img src="../images/cfs-converters-3.png" height=100>

---
### Transactions
- Read before write
- Won't work when client goes offline
- Can be used to ensure that your changes are atomic
<img src="../images/cfs-transaction.png" height=400>

---
### Batch
- Any combination of set, update and delete
<img src="../images/cfs-batch.png">

---
### Offline
Firestore support offline support out-of-the-box

This is done by having a local database which is synced with the server.

When connectivity is lost, the local database is used to provide offline support.

Once connectivity is restored, the local database is synced with the server and migration is performed.

---
### DIY
- Rewrite the app to use Cloud Firestore instead of Realtime database





