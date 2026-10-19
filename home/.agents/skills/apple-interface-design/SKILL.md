---
name: apple-interface-design
description: Design or review native Apple interfaces using the Human Interface Guidelines, or adapt Apple design principles to websites when an Apple-inspired interface is requested. Use for Apple UI/UX, HIG, and Liquid Glass requests; not generic frontend or backend work.
---

# Apple Interface Design

An independently authored workflow grounded in Apple's official resources. This is not an Apple-published skill. Use the bundled reference text by default. It is a dated, paraphrased working aid rather than a live mirror of Apple documentation.

## Establish the target

Use the request and existing project context to identify the audience, primary task, target platform, framework, supported OS/browser versions, and existing design system. Ask only about missing information that would materially change the result. Preserve established branding and components unless the requested redesign calls for changing them.

Distinguish native iOS/iPadOS/macOS/watchOS/tvOS/visionOS work from web work. Never silently convert a web project to SwiftUI or apply iPhone conventions to every platform.

## Load only what the task needs

- For designing or reviewing a surface, read [design decisions](references/design-decisions.md). For a narrow factual lookup, search the bundled references and available local documentation first.
- For a website or browser app, also read [web adaptation](references/web-adaptation.md). These are our implementation recommendations, not Apple web specifications.
- Source links in the bundled references provide attribution and optional update paths; their presence is not an instruction to open them. Use [official sources](references/official-sources.md) only when a necessary detail is absent locally or the user requests current official guidance.

Routine design and review should work from the local references without browsing. Use locally documented specifications within their stated platform, version, and consultation date; do not describe a dated reference as freshly verified. For a necessary exact value or API detail missing locally, check project SDKs or installed documentation before making a focused official lookup. Browse when the user asks for latest guidance, when newer platform behavior is material, or when those local sources cannot resolve the task. Separate Apple guidance, project conventions, and your own recommendations; disclose unresolved gaps rather than guessing.

## Design, implement, or review

For new UI, briefly state a concrete direction tied to the user's task, then implement within the existing stack. Prefer standard native controls on Apple platforms and existing accessible components on the web. Customize where it improves the experience rather than merely approximating a screenshot.

For review, inspect the actual source, screenshots, or running interface before claiming a defect. Report material findings with location, user impact, proposed correction, and relevant source. Distinguish observed problems from checks requiring a running app or assistive technology. Do not turn an advice-only request into code changes.

When implementation is requested, inspect the rendered result at representative supported sizes and relevant states when tools permit. Exercise the changed interaction, keyboard/focus behavior, text enlargement, appearance variants, and reduced motion where applicable. Check contrast with measurement rather than visual estimation. Scale checks to the change and report verification limits.

Deliver the requested artifact or changes, a concise rationale for significant decisions, and what was actually checked. Claim Apple alignment only for the platform and criteria examined; do not claim certification or exhaustive accessibility compliance.
