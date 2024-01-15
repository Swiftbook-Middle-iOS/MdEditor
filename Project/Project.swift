import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "Swiftbook-Middle-iOS" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "Swiftbook Middle iOS Team 3" }
	public static var targetVersion: String { "15.0" }
	public static var bundleId: String { "\(organizationName).\(projectName)" }
}

public var swiftLintTargetScript: TargetScript {
	let swiftLintScriptString = """
								export PATH="$PATH:/opt/homebrew/bin"
								if which swiftlint > /dev/null; then
									swiftlint
								else
									echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
									exit 1
								fi
								"""

	return TargetScript.pre(
		script: swiftLintScriptString,
		name: "Run Swiftlint",
		basedOnDependencyAnalysis: false
	)
}

public var swiftGenTargetScript: TargetScript {
    let swiftGenScriptString = """
                                cd ./swiftgen-6.6.2/bin/
                                ./swiftgen
                                """

    return TargetScript.pre(
        script: swiftGenScriptString,
        name: "Run SwiftGen",
        basedOnDependencyAnalysis: false
    )
}

private let myScripts: [TargetScript] = [
	swiftLintTargetScript,
    swiftGenTargetScript
]

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage"))
	],
	settings: .settings(
		base: [
			"DEVELOPMENT_TEAM": "\(ProjectSettings.developmentTeam)",
			"MARKETING_VERSION": "\(ProjectSettings.appVersionName)",
			"CURRENT_PROJECT_VERSION": "\(ProjectSettings.appVersionBuild)",
			"DEBUG_INFORMATION_FOTMAT": "dwarf-with-dsym"
		],
		defaultSettings: .recommended()
	),
	targets: [
		Target(
			name: ProjectSettings.projectName,
			platform: .iOS,
			product: .app,
			bundleId: "ru.\(ProjectSettings.bundleId)",
			deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
			infoPlist: "Info.plist",
			sources: ["Sources/**"],
			resources: ["Resources/**"],
			scripts: myScripts,
			dependencies: [
				/* Target dependencies can be defined here */
				/* .framework(path: "framework") */
				.package(product: "TaskManagerPackage")
			]
		),
		Target(
			name: "\(ProjectSettings.projectName)Tests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "ru.\(ProjectSettings.bundleId)Tests",
			deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
			infoPlist: .none,
			sources: ["Tests/**"],
			resources: ["Resources/**"],
			scripts: myScripts,
			dependencies: [
				/* Target dependencies can be defined here */
				/* .framework(path: "framework") */
				.target(name: "\(ProjectSettings.projectName)")
			],
			settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
		)
	]
)
