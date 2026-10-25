## Avalonia profile

- Inspect the application lifetime, target platforms, view/view-model conventions, compiled binding settings, themes, and existing UI-test strategy before editing.
- Keep platform-specific behavior behind existing seams and preserve cross-platform compatibility unless the task explicitly narrows it.
- Validate binding and XAML compilation plus the affected platform build. For visual changes, capture observed evidence on an available target and state which platforms were not exercised.
- Keep business behavior outside views where the existing architecture supports it; do not impose a new MVVM framework or navigation stack for a local change.
