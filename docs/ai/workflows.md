# Arbetsflöden

Pilar visar ett vanligt nästa steg, inte automatiskt tillstånd eller nya rättigheter. Streckade val är valfria.

## Från idé till leverans

```text
idé
 │
 ├──> grill-me -----------------------------┐
 │                                          │
 └──> grill-with-docs ──> domain-modeling   │
                          (vid behov)        │
                    ┌───────────────────────┘
                    v
                 to-spec ──> plan-tasks
                 R/D/AC-ID      T-ID + R/D/AC-ID
                    │             │
                    │             ├──> implement ──> tdd
                    │             │    evidens/AC       │
                    │             └──> implement-spec   │
                    │                    (explicit)      │
                    └────────────────────────┬───────────┘
                                             v
                                       code-review ──> pr ──> retro
```

För en liten, redan beslutad ändring kan flödet gå direkt från samtal till `implement`. `to-spec` och `plan-tasks` är till för arbete som behöver överleva flera sessioner eller samordnas.

## Felsökning

```text
symptom
   │
   v
diagnosing-bugs
   │
   ├── reproduktion ──> minimering ──> hypoteser ──> evidens
   │                                                   │
   └───────────────────────────────────────────────────┘
                                                       v
                                              godkänd fix ──> tdd
                                                               │
                                                               v
                                                         code-review
```

`diagnosing-bugs` får användas utan att en fix är godkänd. Övergången till implementation är en separat behörighetsgräns.

## Stor specifikation med worktrees

```text
godkänd spec + task graph
            │
            v
      implement-spec (explicit)
            │
            v
      integration branch
       /        |        \
      v         v         v
 worktree A  worktree B  blockerad C
 implement   implement      │
 + tdd       + tdd          │
      \         /           │
       v       v            │
    validera och integrera   │
       │             │       │
       │        fel/avbrott/konflikt
       │             │
       │             v
       │      rekonstruera från Git
       │      klassificera + handoff
       │             │
       │       godkänd återstart
       │             │
       └─────────────┴── låser upp C
                         │
                         v
                  full validering
                         │
                         v
                    code-review
```

Varje worktree ägs av en uppgift. Integration sker en uppgift i taget. Vid avbrott rekonstrueras läget från Git och observerad evidens; agentrapporter räcker inte. Delarbete bevaras, semantiska konflikter stoppar flödet och retries loopar inte automatiskt. Push, PR, deploy och destruktiv städning kräver egna godkännanden.

## Spårbar handoff

```text
krav R-* ──┬──> task T-* ──> acceptance AC-* ──> evidens
beslut D-* ┘         │                                  │
                     └──────── handoff ─────────────────┘
```

Projektets befintliga ID:n och lagringsplats återanvänds. Om källan saknar ID:n skapas korta stabila referenser i det befintliga artefaktet; ett nytt dokumentformat eller tracker införs inte.

## Projektinstallation och uppdatering

```text
setup-project
     │
     ├── läs repo och välj profiler
     │          │
     │          └── dotnet <── azure-functions / avalonia
     v
ai-project preview ──> diff ──> godkännande ──> ai-project apply
     │                                            │
     └── ändrat förvaltat block? ── ja ──> STOPP  └── projektvalidering
```

Endast blocket mellan `dotfiles-ai:start` och `dotfiles-ai:end` förvaltas. En checksumma skyddar lokala ändringar.

## Skapande och förbättring av skills

```text
nytt återanvändbart behov
          │
          v
 Codex $skill-creator ──> lokala konventioner ──> quick_validate
                                                   │
observerat problem ──> improve-skill ──────────────┤
                                                   v
upstream-förändring ──> update-skills ──> förslag ──> ai-check ──> dokumentation
```

`update-skills` är en granskning, aldrig en automatisk synkronisering.

## Beroenden mellan skills

```text
grill-me ────────────────> grilling
grill-with-docs ─────────> grilling
        └───────────────-> domain-modeling (valfritt)
improve-codebase-architecture ─> codebase-design
        └──────────────────────> grilling
wayfinder ───────────────> grilling
        ├ - - - - - - - -> research
        └ - - - - - - - -> prototype
implement ─ - - - - - - -> tdd
        └ - - - - - - - -> code-review
implement-spec ──────────> implement ──> tdd
        └────────────────> code-review
retro ──────────────────> writing-for-agents
improve-skill ───────────> Codex $skill-creator
update-skills ───────────> improve-skill
setup-project ───────────> scripts/ai-project
validate-dotfiles ───────> just ai-check / just check / ai-skills-status
```

Heldragen pil betyder ett procedurellt beroende. Streckad pil betyder ett valfritt steg när arbetets natur kräver det.
