import ProjectDescription

enum ProjectSettings {
	public static var organizationName: String { "Swiftbook-Middle-iOS" }
	public static var projectName: String { "MdEditor" }
	public static var appVersionName: String { "1.0.0" }
	public static var appVersionBuild: Int { 1 }
	public static var developmentTeam: String { "Swiftbook Middle iOS Team 3" }
	public static var targetVersion: String { "16.0" }
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

private let myScripts: [TargetScript] = [
	swiftLintTargetScript
]

let target = Target(
	name: ProjectSettings.projectName,
	platform: .iOS,
	product: .app,
	bundleId: "ru.\(ProjectSettings.bundleId)",
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: "Info.plist",
	sources: ["Sources/**", "Shared/**"],
	resources: ["Resources/**", .folderReference(path: "Assets", tags: [], inclusionCondition: nil)],
	scripts: myScripts,
	dependencies: [
		.package(product: "TaskManagerPackage"),
		.package(product: "MarkdownPackage")
	]
)

let testTarget = Target(
	name: "\(ProjectSettings.projectName)Tests",
	platform: .iOS,
	product: .unitTests,
	bundleId: "ru.\(ProjectSettings.bundleId)Tests",
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: .none,
	sources: ["Tests/**", "Shared/**"],
	resources: ["Resources/**"],
	scripts: myScripts,
	dependencies: [
		/* Target dependencies can be defined here */
		/* .framework(path: "framework") */
		.target(name: "\(ProjectSettings.projectName)")
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let uiTestTarget = Target(
	name: "\(ProjectSettings.projectName)UITests",
	platform: .iOS,
	product: .uiTests,
	bundleId: "ru.\(ProjectSettings.bundleId)UITests",
	deploymentTarget: .iOS(targetVersion: ProjectSettings.targetVersion, devices: .iphone),
	infoPlist: .none,
	sources: ["UITests/Sources/**", "Shared/**"],
	resources: ["Resources/**"],
	scripts: myScripts,
	dependencies: [
		.target(name: "\(ProjectSettings.projectName)")
	],
	settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"])
)

let project = Project(
	name: ProjectSettings.projectName,
	organizationName: ProjectSettings.organizationName,
	options: .options(
		defaultKnownRegions: ["en", "ru"],
		developmentRegion: "en"
	),
	packages: [
		.local(path: .relativeToManifest("../Packages/TaskManagerPackage")),
		.local(path: .relativeToManifest("../Packages/MarkdownPackage"))
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
	targets: [target, testTarget, uiTestTarget],
	schemes: [
		Scheme(
			name: "MdEditor",
			shared: true,
			buildAction: .buildAction(targets: [TargetReference(stringLiteral: ProjectSettings.projectName)]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: TargetReference(stringLiteral: ProjectSettings.projectName))
		),
		Scheme(
			name: "MdEditorTests",
			shared: true,
			buildAction: .buildAction(targets: [TargetReference(stringLiteral: "\(ProjectSettings.projectName)Tests")]),
			testAction: .targets(["\(ProjectSettings.projectName)Tests"]),
			runAction: .runAction(executable: TargetReference(stringLiteral: "\(ProjectSettings.projectName)Tests"))
		),
		Scheme(
			name: "MdEditorUITests",
			shared: true,
			buildAction: .buildAction(targets: [TargetReference(stringLiteral: "\(ProjectSettings.projectName)UITests")]),
			testAction: .targets(["\(ProjectSettings.projectName)UITests"]),
			runAction: .runAction(executable: TargetReference(stringLiteral: "\(ProjectSettings.projectName)UITests"))
		)
	],
	resourceSynthesizers: [.strings()]
)
