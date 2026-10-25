# AI-utvecklingsverktyg

Det här är en Codex-fokuserad verktygslåda för återanvändbara utvecklingsflöden. Dotfiles-repot är källan för globala skills, projekttemplat, säkerhetsregler och dokumentation. Verktygslådan kopierar inte en extern skill-samling vid körning.

## Installation

Codex installeras redan via `Brewfile`. De repohanterade skillsen länkas en och en, så att inbyggda skills och andra installerade paket lämnas orörda:

```sh
just ai-skills-status
just ai-skills
just ai-check
```

Målet är `${CODEX_HOME:-$HOME/.codex}/skills`. Installationen gör först en fullständig kollisionskontroll och skriver inget om en okänd konflikt finns. `just bootstrap` inkluderar `ai-skills`.

## Globala skills och projekttemplat

Globala skills finns i `ai/skills/` och kan användas i alla projekt efter installation. Smala disciplineskills kan väljas automatiskt; stora eller muterande arbetsflöden kräver uttrycklig invocation. Valet av skill ger aldrig nya rättigheter.

Projekttemplatet lägger till ett checksummaskyddat, förvaltat block i projektets `AGENTS.md`. All text utanför blocket ägs av projektet. Tillgängliga profiler är `dotnet`, `azure-functions` och `avalonia`.

Förhandsgranska alltid först:

```sh
just project-preview /path/to/project
just project-preview /path/to/project dotnet
just project-apply /path/to/project dotnet
```

Flera profiler kan anges direkt:

```sh
scripts/ai-project preview --project /path/to/project \
  --profile azure-functions --profile avalonia
```

En ändrad förvaltad sektion skrivs aldrig över automatiskt. Verktyget visar diff och stoppar.

## Användning

Anropa en manuell skill med dess namn, exempelvis `$grill-me`, `$implement` eller `$setup-project`. Codex kan välja en automatisk skill när dess smala användningsfall matchar. Se [skills.md](skills.md) för full katalog.

Mer information:

- [Arbetsflöden och diagram](workflows.md)
- [Arkitektur och säkerhetsmodell](architecture.md)
- [Implementationsbeslut och kvarstående arbete](plans/implementation.md)
