# magpie

Magpie is an idea board iOS app for sprint retrospective meetings implemented using [Firebase](https://firebase.google.com). It is the iOS counterpart of [Kestrel](https://github.com/donny/kestrel).

### Background

This project is part of [52projects](https://donny.github.io/52projects/) and the new stuff that I learn through this project: [Firebase iOS](https://firebase.google.com/docs/ios/setup), [Eureka](https://github.com/xmartlabs/Eureka), and [APESuperHUD](https://github.com/apegroup/APESuperHUD).

### Project

Magpie is the iOS app version of [Kestrel](https://github.com/donny/kestrel) using [Firebase iOS](https://firebase.google.com/docs/ios/setup). The iOS app talks to the same database as used by Kestrel. It utilises the Firebase Realtime Database that synchronises in realtime to every connected client (using WebSocket). After logging in, a user can view the lists and cards for the sprint retrospective meeting. The screenshots of the iOS app can be seen below:

![Screenshot1](https://raw.githubusercontent.com/donny/magpie/master/screenshot1.png)
![Screenshot2](https://raw.githubusercontent.com/donny/magpie/master/screenshot2.png)
![Screenshot3](https://raw.githubusercontent.com/donny/magpie/master/screenshot3.png)

### Implementation

The app is a standard iPhone app implemented using Swift and it's using [CocoaPods](https://cocoapods.org) as the dependency manager. The app utilises [APESuperHUD](https://github.com/apegroup/APESuperHUD) to display the modal message view. In addition, Magpie uses [Eureka](https://github.com/xmartlabs/Eureka) to build the form for `LogInViewController` using custom operators:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    form +++ Section("Authentication")
        <<< EmailRow() { row in
            row.title = "Email"
            row.tag = "email"
        }
        <<< PasswordRow() {
            $0.title = "Password"
            $0.tag = "password"
        }
    ...
}
```

Magpie uses convenient classes as provided by the `FirebaseDatabaseUI` package to bind the Firebase data to a table view and a collection view. For example, here is the `viewDidLoad` implementation of `BoardViewController`:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    ...
    let ref = FIRDatabase.database().reference()
    let query = ref.child("lists").queryOrderedByKey()

    dataSource = tableView.bind(to: query, populateCell: { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardTableViewCell", for: indexPath)
        guard let value = snapshot.value as? NSDictionary else { return cell }

        let title = value["title"] as? String ?? ""
        cell.textLabel?.text = title

        return cell
    })
}

```

### Conclusion

...
