// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HKKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "HKKit",
            targets: ["HKKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HKKit",
            path: "Pod/Classes"),
    
    ],
    swiftLanguageVersions: [.v5]

)

