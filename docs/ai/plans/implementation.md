# Implementationsplan och beslut

## Status

- **Decided:** Dotfiles-repot är source of truth för 32 globala, repohanterade skills och projekttemplatet.
- **Decided:** Codex inbyggda `$skill-creator` tillhandahåller `create-skill`-förmågan; en duplicerad lokal skill skapas inte.
- **Decided:** Smala skills får väljas automatiskt. Stora eller muterande workflows är manuella. Invocation ger aldrig nya rättigheter.
- **Decided:** Trackers är valfria adapters; lokal Markdown är fallback efter godkännande.
- **Decided:** Projektuppdateringar använder ett checksummaskyddat block i `AGENTS.md`.
- **Decided:** Utvalda projektlokala skills är fysiska, manifestförvaltade kopior; nödvändiga beroenden följer med medan dotfiles-specifika skills undantas.
- **Decided:** `implement-spec` får använda isolerade branches och worktrees endast när skillen uttryckligen anropas.

## Upstream-granskning

**Verified 2026-10-25:** `mattpocock/skills` granskades vid commit `5beb35b040e3de97e54fa9e386d7e42d15c295c2` under MIT-licens.

Adopterat som principer:

- skillnad mellan orkestrerande manuella skills och återanvändbara disciplineskills;
- beslutsträd och frågefront i `grilling`;
- vertikala tasks med blockeringskanter;
- TDD vid förhandlade test-seams;
- separat granskning av korrekthet och intent;
- worktree-isolering för en stor task graph;
- retrospektiv förbättring av agentmiljön.

Avsiktliga avvikelser:

- Codex-native `agents/openai.yaml` ersätter Claude-specifik frontmatter.
- Skills kräver inte en abstrakt “Skill tool”.
- Subagents är valfria och används endast när miljön och instruktionerna tillåter det.
- HTML/CDN-rapporter och automatisk browseröppning är inte standard.
- GitHub är inte obligatorisk tracker.
- Glossarier, ADR:er och dokumentträd skapas endast vid behov.
- Projektets approvalmodell gäller även efter skill-invocation.

## Genomfört

- 32 substantiella skills med Codex-metadata och dokumenterade beroenden.
- Kollisionssäker global symlinkinstallation och statuskontroll.
- Preview/apply för projektlokala skillkopior med beroendeexpansion, checksummamanifest, driftskydd och transaktionell katalogersättning.
- Basprojektmall samt profiler för .NET, Azure Functions och Avalonia.
- Preview/apply-flöde med checksumma och skydd för projektanpassningar.
- Deterministisk toolkitvalidering integrerad i `just check`.
- Spårbara handoffs från krav och beslut till tasks, acceptance criteria och verifiering.
- Recoveryregler för agentfel, delarbete, konflikter, avbrott och säker återstart i `implement-spec`.
- Persistenta beteendetester samt separata read-only Codex forward-evals.
- Svensk dokumentation och ASCII-diagram under `docs/ai/`.

## Trade-offs

- Skills är medvetet kortare än upstream. Det minskar kontextlast och harnesskoppling men lämnar fler projektspecifika val till Codex och repository instructions.
- Projekttemplatet förvaltar ett block i stället för hela `AGENTS.md`. Det begränsar automatiska uppdateringar men skyddar projektets egna anpassningar.
- Ingen ny YAML- eller templatingdependency införs. Bash, `yq`, `rg`, `diff` och SHA-256-verktyg återanvänds från befintlig miljö.

## Kvarstående och uppskjutet

- **Open:** Verklig användning får visa om fler riskspecifika forward-evals behövs. Nya scenarier kräver ett observerbart invariant och ska inte testa formulering.
- **Open:** Stöd för ytterligare språkprofiler införs först vid ett konkret projektbehov.
- **Deferred:** Automatisk publicering som plugin eller upstream-synkronisering.
- **Deferred:** Tracker-specifika integrationsscript; nuvarande skills använder de verktyg projektmiljön redan erbjuder.
