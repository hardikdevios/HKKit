// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HKKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "HKKit",
            targets: ["HKKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/robb/Cartography", .upToNextMinor(from: "4.0.0")),
        .package(url: "https://github.com/melvitax/DateHelper", .upToNextMinor(from: "4.3.0"))
    ],
    targets: [
        .target(name: "HKKit",dependencies: ["Cartography","AFDateHelper"], path: "Pod/Classes"),
    ],
    swiftLanguageVersions: [.v5]

)

