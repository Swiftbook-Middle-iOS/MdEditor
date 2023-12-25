import ProjectDescription

public var scripts: [TargetScript] {
	var scripts = [TargetScript]()
	
	let swiftLintScriptString = "SwiftLint"
	let swiftLintScript = TargetScript.post(script: swiftLintScriptString, name: "SwiftLint")
	
	scripts.append(swiftLintScript)
	return scripts
}

let project = Project(
	name: "MdEditor",
	organizationName: "Swiftbook-Middle-iOS",
	targets: [
		Target(
			name: "MdEditor",
			platform: .iOS,
			product: .app,
			bundleId: "ru.Swiftbook-Middle-iOS.MdEditor",
			infoPlist: "Info.plist",
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			headers: .headers(
				public: ["Sources/public/A/**", "Sources/public/B/**"],
				private: "Sources/private/**",
				project: ["Sources/project/A/**", "Sources/project/B/**"]
			),
			scripts: scripts,
			dependencies: [
				/* Target dependencies can be defined here */
				/* .framework(path: "framework") */
			]
		)
	]
)
