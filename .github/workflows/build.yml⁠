name: Build IPA
on: [workflow_dispatch]

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Compile and Package App
        run: |
          mkdir -p Payload/DiscordMod.app
          xcrun -sdk iphoneos swiftc -target arm64-apple-ios14.0 ViewController.swift -emit-executable -o Payload/DiscordMod.app/DiscordMod
          cp Info.plist Payload/DiscordMod.app/
          cp hellfire.js Payload/DiscordMod.app/
          zip -r DiscordMod.ipa Payload
          
      - name: Upload IPA
        uses: actions/upload-artifact@v4
        with:
          name: DiscordMod-IPA
          path: DiscordMod.ipa
