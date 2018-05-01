// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "blogger",
    dependencies: [
		    .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
            .Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 0),
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)
