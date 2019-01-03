# Looped

Browse and create your own GIFs

## Requirements

Project requires:

- **Xcode 10.x
- **[Carthage](https://github.com/Carthage/Carthage)
- **[CocoaPods](https://github.com/CocoaPods/CocoaPods)
- **[CocoaPods-Keys](https://github.com/orta/cocoapods-keys)

## Configuration

The project uses [gfycat](https://developers.gfycat.com/api/) API

1. Create a `.env` file with your credentials in the project's directory

```swift
    CLIENT_ID=YOUR_CLIENT_ID
    CLIENT_SECRET=YOUR_SECRET_KEY
```

2. Install CocoaPods/CocoaPods-Keys:

    ```sh
    $ pod install
    ```

3. Install Carthage dependencies:

    ```sh
    $ carthage bootstrap --platform iOS --cache-builds
    ```

4. Open `Looped.xcodeproj` and build the project
