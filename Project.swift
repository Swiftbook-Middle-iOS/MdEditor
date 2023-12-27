import ProjectDescription

public var scripts: [TargetScript] {
	var scripts = [TargetScript]()
	
	let swiftLintScriptString = """
								export PATH="$PATH:/opt/homebrew/bin"
								if which swiftlint > /dev/null; then
									swiftlint
								else
									echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
									exit 1
								fi 
								"""
								
	let swiftLintScript = TargetScript.post(
		script: swiftLintScriptString,
		name: "SwiftLint",
		basedOnDependencyAnalysis: false
	)

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
