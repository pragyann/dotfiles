# Applying Apple principles on the web

These are our adaptations of HIG concepts to browser interfaces, not an Apple-authored web design system. Preserve the product's identity, existing framework, supported browsers, and user expectations.

## Translate the intent

| Native design concern | Browser implementation choice |
| --- | --- |
| Legible hierarchy and text scaling | Use semantic headings, relative units, and layouts that survive browser zoom and larger text. Native point sizes are not CSS pixel specifications. |
| Platform familiarity | Preserve links, browser history, open-in-new-tab, selection, and expected form behavior. A website does not need to imitate native app chrome. |
| Adaptive layout | Respond to content and available width. Test touch, mouse, and keyboard; avoid hover-only functionality. |
| Appearance-aware colors | Use semantic tokens and check contrast pairs in supported appearances. Native system color APIs do not automatically translate to CSS. |
| Reduced motion | Use `prefers-reduced-motion` when motion is present and preserve meaningful feedback without it. |
| Layered materials | If translucency adds useful hierarchy, supply a legible opaque fallback and inspect actual background content. CSS blur approximates a visual effect; it is not native Liquid Glass. |

## Accessible implementation

Prefer native HTML elements and the project's established accessible component library. Use links for navigation and buttons for actions. Ensure dialogs, menus, and custom widgets have appropriate behavior and focus handling. Preserve keyboard interaction and visible focus indicators.

For exact browser accessibility criteria, verify the relevant [WCAG guidance](https://www.w3.org/WAI/standards-guidelines/wcag/) rather than transferring native Apple measurements to the web. Distinguish measured criteria from broader usability recommendations.

## Fonts, symbols, and identity

An Apple-inspired website can use the browser's system font stack without bundling an Apple font. Preserve an established brand font when suitable. If downloaded Apple fonts, symbols, or templates are needed, check their usage terms before distribution. Prefer the project's licensed web icon library when it fits. Do not add Apple logos or claim affiliation as part of an aesthetic adaptation.

## Representative verification

Inspect reflow, long text, focus visibility, touch targets, overlapping sticky elements, and changed loading/error states. Test translucent UI against backgrounds that move beneath it. Match scope to the change: a static component needs different checks from navigation or a modal. State the browser sizes, states, and interactions checked instead of declaring universal compliance.
