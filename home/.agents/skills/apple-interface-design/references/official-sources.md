# Official sources and current lookups

This index selects entry points rather than mirroring Apple's documentation. The principles, layout, typography, color, accessibility, motion, and materials pages were consulted on 2026-10-19. Other links are navigation entry points, not a claim that every nested article was reviewed. Read local guidance first. These URLs are attribution and maintenance references, not mandatory fetches. Recheck only when needed to fill a material local gap, resolve newer platform behavior, or satisfy an explicit request for current guidance.

## Choose the source

| Question | Official source |
| --- | --- |
| Overall resources | [Apple Design](https://developer.apple.com/design/) |
| HIG topic navigation | [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) |
| Purpose, agency, familiarity, and other principles | [Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles) |
| Platform differences | [Getting started](https://developer.apple.com/design/human-interface-guidelines/getting-started) |
| Layout and resizing | [Layout](https://developer.apple.com/design/human-interface-guidelines/layout) |
| Type hierarchy and Dynamic Type | [Typography](https://developer.apple.com/design/human-interface-guidelines/typography) |
| Semantic color and appearances | [Color](https://developer.apple.com/design/human-interface-guidelines/color) |
| Accessibility and preferences | [Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility) |
| Liquid Glass and content layers | [Materials](https://developer.apple.com/design/human-interface-guidelines/materials) |
| Motion and feedback | [Motion](https://developer.apple.com/design/human-interface-guidelines/motion) |
| Navigation, controls, and presentations | [Components](https://developer.apple.com/design/human-interface-guidelines/components) |
| Onboarding, errors, and task flows | [Patterns](https://developer.apple.com/design/human-interface-guidelines/patterns) |
| Keyboard, touch, and other input | [Inputs](https://developer.apple.com/design/human-interface-guidelines/inputs) |
| Official templates and UI kits | [Design Resources](https://developer.apple.com/design/resources/) |
| Font downloads and terms | [Fonts](https://developer.apple.com/fonts/) |
| Symbols and tools | [SF Symbols](https://developer.apple.com/sf-symbols/) and [Icon Composer](https://developer.apple.com/icon-composer/) |
| Native API signatures and availability | [SwiftUI](https://developer.apple.com/documentation/swiftui) and the framework documentation linked by the HIG |

## Retrieve only when needed

For routine tasks, use the bundled design-decisions and web-adaptation text without opening source URLs. Search available local references, project SDKs, and installed documentation for required details first. If the task needs a missing detail or current official verification, open only the relevant official pages using available web/documentation tools. Some Apple pages return only a JavaScript shell. Check the HTML's `rel="alternate" type="text/markdown"` link or visible View Markdown link. For example, the HIG index exposes [human-interface-guidelines.md](https://developer.apple.com/design/human-interface-guidelines.md); the consulted topic pages also expose a `.md` form. Follow the published alternate rather than assuming every Apple URL supports it.

If Markdown retrieval fails, use a browser tool when available. A title, JavaScript notice, empty response, or search snippet is insufficient evidence for precise specifications. Explain unavailable verification and continue with grounded general recommendations when useful. Cite human-readable official pages in the deliverable and distinguish version-specific examples from deployment requirements.

## Apple's exported skills

Apple describes SwiftUI Specialist and What's New in SwiftUI skills and export for other tools in [What's new in SwiftUI, WWDC26](https://developer.apple.com/videos/play/wwdc2026/269/?time=1588). If official skills are already installed, read the one matching a native implementation task rather than duplicating its API guidance here. This independent skill does not require Xcode or those skills.

To inspect export options, use `xcrun agent skills export --help`. The installed tool advertises `--output-dir <path>` and `--replace-existing`; choose a new output directory and avoid replacing existing skills. Export can require launching Xcode, so follow environment permissions. Inspect exported definitions before installing selected skills. Keep Apple's authored files and attribution distinct from custom instructions; do not install the entire corpus for one UI task.

## Maintenance

When updating this skill, review relevant live sources and revise affected guidance. Update consultation dates for pages actually checked. Preserve attribution and the distinction between HIG guidance and our web adaptations. Do not bundle the full HIG, fonts, or Apple artwork merely to make the skill self-contained.
