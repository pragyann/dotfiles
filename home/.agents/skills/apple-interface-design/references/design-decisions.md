# Design decisions

This is an independent synthesis for applying the HIG, not a replacement for it. Use this local text for routine work and read only sections relevant to the task. Source links identify provenance; do not open them automatically. For exact requirements absent here, follow the local-first lookup policy in SKILL.md.

## Purpose, familiarity, and control

Identify what people come to accomplish and make that path clear. Keep navigation predictable, show state and progress, and make recovery possible. Preserve familiar interactions unless a custom interaction solves a specific problem. Keep decorative elements subordinate to the task. Explain significant departures from a platform convention. Source: [Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles).

## Layout

Group related information and make primary content and actions easy to locate. Adapt structure to available space, input methods, and content rather than scaling a fixed screenshot. Native layouts need the target platform's safe areas, system chrome, and resizing conventions. Avoid treating an iPhone tab bar or a Mac sidebar as a universal navigation pattern. Source: [Layout](https://developer.apple.com/design/human-interface-guidelines/layout).

## Typography

Use a small, coherent hierarchy with deliberate size and weight differences. Maintain legibility and relative emphasis as text grows. Favor native text styles for native apps so text can respond to user settings. Check long labels, localization, and error messages before fixing heights or truncation rules. Verify actual type specifications for the platform rather than sharing one numeric scale across devices. Source: [Typography](https://developer.apple.com/design/human-interface-guidelines/typography).

## Color and appearance

Assign colors semantic roles and use each role consistently. Native semantic colors can adapt to system appearance and accessibility preferences; custom colors need equivalent care. Check foreground/background pairs in supported appearances. Convey status and interactivity with labels, shapes, or other cues as well as color. Source: [Color](https://developer.apple.com/design/human-interface-guidelines/color).

## Materials and Liquid Glass

Treat content and functional chrome as distinct layers. Apple's Liquid Glass guidance targets navigation and controls above content, with limited custom use. Do not apply glass to every content card. Prefer the system implementation on supported native platforms; verify APIs and deployment availability before adoption. Check legibility over actual underlying content and with accessibility preferences. Source: [Materials](https://developer.apple.com/design/human-interface-guidelines/materials).

## Accessibility and interaction states

Evaluate the task with enlarged text, keyboard access, assistive technology, and alternative cues. Check names, roles, values, focus, and reading order where applicable. Include recovery for failed actions and clear loading, empty, disabled, and success states where the affected flow needs them. Check platform-specific guidance before quoting target sizes or thresholds. Source: [Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility).

## Motion

Use animation to explain relationships, progress, or feedback. Keep routine actions responsive and interruptible where possible. Avoid making motion the only carrier of information. Respect reduced-motion preferences and inspect the alternative experience. Timing and easing should serve the interaction; do not invent universal Apple animation constants. Source: [Motion](https://developer.apple.com/design/human-interface-guidelines/motion).
