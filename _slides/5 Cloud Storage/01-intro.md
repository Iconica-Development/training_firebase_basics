# Cloud Storage
---

### Setup
<img src="../images/storage-setup-2.png">
<img src="../images/storage-setup.png">

---
### Reference
<img src="../images/storage-ref.png">

---
### Listing
- list() & listAll() -> ListResult

- items -> Files in the bucket
- prefixes -> Nested directories

- list can be limited using ListOptions

---
### URLs
- Often Firebase Storage is used as a CDN (Content Delivery Network) in applications
- The getDownloadUrl() method returns a URL that can be used to retrieve the file.

- In flutter, in case of an image you can use the Image.network() widget

- CORS needs to be configured in the Firebase console for this to work for web apps

---
### Upload
- putFile() (File from path_provider)
- putString() (String)
- putData() (Uint8List)

- Meta data can be added using SettableMetadata

---
### Download
- getData() (Uint8List)
- writeToFile() (File)

---
### Tasks
- All uploads and downloads are done using tasks
- Tasks can be cancelled, paused and resumed using the corresponding methods
- Tasks have a state and can be used to show progress

---
### DIY
- Implement Firebase Storage in your own project
- Posts can have images, videos, audio, documents, etc.
- User profile (Cloud Firestore) with profile pictures



