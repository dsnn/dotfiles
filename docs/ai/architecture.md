# Arkitektur

## Källor och struktur

Dotfiles-repot är enda skrivbara källan för den lokala verktygslådan:

```text
ai/skills/                  repohanterade globala skills
ai/project-skills.json      beroenden och undantag för projektkopior
ai/project-template/        basblock och stackprofiler
scripts/ai-skills           global länkning samt projektkopiering
scripts/ai-project          projekt-preview och uppdatering
scripts/validate-ai-toolkit deterministisk validering
docs/ai/                    mänsklig dokumentation
```

Codex inbyggda `.system`-skills och tredjepartsskills ägs inte av repot. `create-skill` återanvänder den inbyggda `$skill-creator`; lokala skilländringar sker sedan under `ai/skills/`.

## Global installation och discovery

`scripts/ai-skills` länkar varje katalog i `ai/skills/` till `${CODEX_HOME:-$HOME/.codex}/skills/<name>`. En tvåstegsmodell används:

1. Alla mål klassificeras som `linked`, `missing` eller `conflict`.
2. Installation sker endast om inga icke godkända konflikter finns.

Ett uttryckligt `--replace <skill>` flyttar den gamla katalogen till `${CODEX_HOME}/skill-backups/` innan länken skapas. Om länkningen misslyckas återställs backupen.

Codex ser skillens namn och beskrivning före laddning. `agents/openai.yaml` sätter `allow_implicit_invocation: false` för stora och manuella workflows. Automatiska skills har smala beskrivningar. Invocation ändrar aldrig behörighet.

## Projektlokala skillkopior

`scripts/ai-skills copy` expanderar nödvändiga beroenden från `ai/project-skills.json` och kopierar endast den valda mängden till `<projekt>/.agents/skills/`. Katalogerna innehåller fysiska filer och får inte innehålla symlänkar eller absoluta beroenden till dotfiles-repot. Dotfiles-specifika drift- och installationsskills är uttryckligen undantagna. Valfria beroenden visas utan automatisk installation.

Manifestet `.agents/skills/.dotfiles-ai.json` lagrar per förvaltad skill en SHA-256 och filrättighet för varje fil. Det innehåller ingen absolut källsökväg. Vid uppdatering jämförs tre tillstånd:

```text
manifestets baslinje ──┐
projektets filer ──────┼──> oförändrad / säker uppdatering / lokal drift
dotfiles-källan ───────┘
```

Lokal drift stoppar hela körningen. `--overwrite <skill>` godtas endast för en skill som redan finns i manifestet; en oförvaltad katalog kan aldrig tas över. Saknad källa rapporteras utan att projektkopian tas bort. Inför applicering byggs och verifieras kompletta ersättningskataloger i en transaktion under projektets `.agents/`; katalogbyten och manifest sker först när all preflight har lyckats. Vid ett appliceringsfel återställs tidigare förvaltat innehåll där det går och transaktionen behålls för felsökning.

Global länkning och projektkopiering delar källkatalog men inte mål eller tillstånd. Det ena flödet ändrar aldrig det andra.

## Projekttemplat

`scripts/ai-project` komponerar `base.md` och valda profiler. `azure-functions` och `avalonia` inkluderar `dotnet` eftersom deras råd förutsätter .NET-projekt.

Det genererade blocket i `AGENTS.md` innehåller profiler och SHA-256 för innehållet. Vid uppdatering:

- exakt ett korrekt och ordnat markörpar krävs; föräldralösa, duplicerade och trasiga markörer ger stopp;
- symlänkar och icke-reguljära mål avvisas;
- text utanför blocket kopieras byte för byte och befintliga filrättigheter bevaras;
- ett oförändrat block får ersättas efter visad diff och explicit `apply --yes`;
- ett lokalt ändrat block ger stopp;
- applicering sker atomiskt via en temporär fil i projektkatalogen;
- optionala planer, ADR:er, glossarier och task stores skapas inte.

Projektets egna instruktioner har fortsatt kontroll över kommandon, dokumentplacering och godkännanden.

Skillkopiering hanterar inte projekttemplat. `scripts/ai-project` fortsätter ensamt att äga det förvaltade blocket i `AGENTS.md`, vilket undviker två överlappande manifest- och uppdateringsmodeller.

## Beroenden och delade komponenter

Återanvändbar beslutslogik ligger i egna smala skills, exempelvis `grilling`, `codebase-design` och `writing-for-agents`. Orkestrerande skills hänvisar till dem med namn. Deterministisk filhantering ligger i script i stället för att återimplementeras i prompttext.

Trackers är adapters. `to-spec`, `plan-tasks`, `triage` och `wayfinder` använder dokumenterad projektkonfiguration om den finns; annars föreslår de lokal Markdown. Ingen tracker är ett runtime-beroende.

Planeringskedjan återanvänder projektets befintliga identifierare för krav, beslut, uppgifter och acceptance criteria. Om källan saknar identifierare skapar `to-spec` korta stabila referenser i samma artefakt. `plan-tasks`, `implement`, `implement-spec` och `handoff` bevarar relationerna och kopplar observerad verifiering till rätt kriterium.

## `AGENTS.md`-hierarki och säkerhet

Codex läser globala och projektspecifika instruktioner i hierarki. Root-`AGENTS.md` i detta repo styr arbete här. Ett installerat projekttemplat styr sitt projekt och kan kompletteras av smalare instruktioner längre ned i trädet.

Prioritetsmodellen är:

```text
system- och användarinstruktioner
              │
              v
      tillämpliga AGENTS.md
              │
              v
       vald skill/workflow
```

En skill får alltså inte upphäva en approval gate. Destruktiva operationer, global konfiguration, installation, externa writes, commits, push, PR-publicering och deploy följer alltid den högre instruktionen och den uttryckliga användarbegäran.

## `implement-spec`

Denna skill är den enda avsiktliga worktree-orkestreringen. Den kräver explicit invocation, en godkänd spec och task graph samt godkänd Git-plan. Varje task får egen branch och worktree. Integration sker seriellt till en integrationsbranch efter uppdatering och test. Vid fel eller återstart rekonstrueras tillstånd från Git och observerad evidens; delarbete bevaras, retries är begränsade och semantiska konflikter eskaleras. Full validering och `code-review` avslutar flödet. Städning är separat och destruktiv städning kräver godkännande.

## Testmodell

`just ai-test` kör deterministiska beteendetester i temporära kataloger. De verifierar faktiska filoperationer, säker uppdatering, validatorbeteende och invocation policies. `just ai-eval` är en separat opt-in-svit som kör efemära Codex-sessioner i read-only sandbox och utvärderar strukturerade invariants för routing, behörighet, ID-kontinuitet, recovery och safe stopping. Modellevals är inte en del av den deterministiska `just check`-grinden.

## Utökning och upstream

Nya skills skapas med `$skill-creator`, men destinationen är `ai/skills/`. En ny skill ska ha eget återkommande användningsfall, distinkt trigger, avgränsat ansvar och oberoende validering. Lägg inte till en skill för en enda regel eller ett engångsproblem.

Matt Pococks `skills` används som designinspiration under [MIT-licens](upstream-license.md), inte som runtime-beroende eller automatisk upstream. `update-skills` jämför beteende och föreslår selektiv adoption. Senast granskad commit och lokala avvikelser dokumenteras i [plans/implementation.md](plans/implementation.md).
