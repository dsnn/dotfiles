## .NET / C# profile

- Inspect `global.json`, solution and project files, `Directory.Build.*`, NuGet configuration, analyzers, and target frameworks before changing the build.
- Use repository-provided `dotnet` commands. Restore, format, build, test, and migration operations may have different network or state effects; apply the repository's approval rules to each.
- Preserve nullable-reference, analyzer, formatting, and package-management conventions. Avoid broad solution rewrites for a local task.
- Prefer tests through public behavior and existing test projects. Report the selected SDK and exact test target when it affects reproducibility.
