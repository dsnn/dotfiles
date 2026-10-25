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

## Globala och projektlokala skills

Globala skills finns i `ai/skills/` och kan användas i alla projekt efter installation. Smala disciplineskills kan väljas automatiskt; stora eller muterande arbetsflöden kräver uttrycklig invocation. Valet av skill ger aldrig nya rättigheter.

Utvalda skills kan i stället kopieras till ett annat repos `.agents/skills/`. Förhandsgranskning är standard och ändrar inget:

```sh
just ai-skills-copy /path/to/project grill-me plan-tasks
just ai-skills-copy-apply /path/to/project grill-me plan-tasks
just ai-skills-update /path/to/project
just ai-skills-update-apply /path/to/project
```

Projektkopior är fysiska filer, inte symlänkar, och fungerar utan dotfiles-repot. Ett litet manifest i `.agents/skills/.dotfiles-ai.json` håller checksummor och filrättigheter för enbart de skills som verktyget förvaltar. Nödvändiga skillberoenden läggs till och visas i preview; valfria beroenden rapporteras men kopieras inte.

En lokalt ändrad förvaltad skill stoppar hela uppdateringen. Efter granskning kan just den redan förvaltade skillen ersättas med `scripts/ai-skills update apply --yes --project /path --overwrite skill-name`. Flaggan kan aldrig ta över en oförvaltad katalog. Skills som själva förvaltar dotfiles, dess installation eller kompletta globala katalog är inte projektkopierbara.

## Projekttemplat

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

## Tester

`just ai-test` kör deterministiska beteendetester för projekttemplat, projektlokala skillkopior, driftskydd, filskydd och validator. Kommandot ingår i `just ai-check` och använder endast temporära projekt.

`just ai-eval` kör separata, modellbaserade forward-evals för routing, behörighetsgränser, planeringsspårbarhet och återstart. Körningen använder efemära, read-only Codex-sessioner men kräver modellåtkomst och kan därför ha kostnad och viss nondeterminism. Den ingår inte i `just check`.

## Användning

Anropa en manuell skill med dess namn, exempelvis `$grill-me`, `$implement` eller `$setup-project`. Codex kan välja en automatisk skill när dess smala användningsfall matchar. Se [skills.md](skills.md) för full katalog.

Mer information:

- [Arbetsflöden och diagram](workflows.md)
- [Arkitektur och säkerhetsmodell](architecture.md)
- [Implementationsbeslut och kvarstående arbete](plans/implementation.md)
