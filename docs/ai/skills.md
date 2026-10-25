# Skill-katalog

**Manuell** betyder att användaren måste anropa skillen. **Automatisk** betyder att Codex får välja den när beskrivningen matchar. Båda följer samma instruktioner och godkännanderegler.

## Planering och upptäckt

| Skill | Syfte och användning | Läge | Indata → utdata | Beroenden | Exempel |
| --- | --- | --- | --- | --- | --- |
| `grill-me` | Förfina en idé utan att skriva dokument. | Manuell | Idé → beslut, antaganden, öppna frågor | `grilling` | `$grill-me stress-testa min cache-design` |
| `grilling` | Gemensam metod för beslutsträd och frågefront. | Automatisk | Osäkerhet → strukturerade frågor | — | `Kartlägg besluten innan du föreslår något.` |
| `grill-with-docs` | Förfina en projektidé och bevara hållbara beslut. | Manuell | Idé + repo → granskade dokumentändringar | `grilling`, valfritt `domain-modeling` | `$grill-with-docs förfina importflödet` |
| `research` | Undersök tekniska fakta med primärkällor. | Automatisk | Fråga + avgränsning → citerad rapport | — | `Undersök aktuellt stöd för Native AOT.` |
| `domain-modeling` | Klargör begrepp, invariants och livscykler. | Automatisk | Scenarier + kod → preciserad domänmodell | — | `Klargör skillnaden mellan User och Account.` |
| `codebase-design` | Bedöm modulernas djup, seams, locality och testbarhet. | Automatisk | Kod/design → alternativ och trade-offs | — | `Bedöm gränssnittet för ordermodulen.` |
| `improve-codebase-architecture` | Hitta fokuserade arkitekturförbättringar med evidens. | Manuell | Repo + fokus → prioriterade kandidater | `codebase-design`, `grilling` | `$improve-codebase-architecture fokusera på auth` |
| `prototype` | Bygg en begränsad spike för en specifik fråga. | Automatisk | Fråga + framgångssignal → körbar evidens | — | `Prototypa två sätt att strömma resultat.` |

## Specifikation och uppgifter

| Skill | Syfte och användning | Läge | Indata → utdata | Beroenden | Exempel |
| --- | --- | --- | --- | --- | --- |
| `to-spec` | Syntetisera fattade beslut för flersessionsarbete. | Manuell | Samtal + repo → specifikation | Ofta efter `grill-with-docs` | `$to-spec skriv spec för sökflödet` |
| `plan-tasks` | Dela en godkänd spec i vertikala, blockeringsmedvetna uppgifter. | Manuell | Spec → task graph | `to-spec` eller annan plan | `$plan-tasks använd lokal Markdown` |
| `to-questionnaire` | Gör obesvarade beslut svarbara för rätt person. | Manuell | Mottagare + oklarheter → frågeformulär | — | `$to-questionnaire för driftansvarig` |
| `triage` | Rekommendera status, prioritet och nästa handling. | Manuell | Backlog → triageförslag | Valfritt `grilling` | `$triage gå igenom öppna buggar` |
| `wayfinder` | Kartlägg beslut i ett stort, oklart initiativ. | Manuell | Destination + constraints → beslutskarta | `grilling`, valfritt `research`/`prototype` | `$wayfinder planera plattformsbytet` |

## Implementation och kvalitet

| Skill | Syfte och användning | Läge | Indata → utdata | Beroenden | Exempel |
| --- | --- | --- | --- | --- | --- |
| `implement` | Implementera en godkänd, avgränsad uppgift. | Manuell | Uppgift + kriterier → ändring + evidens | `tdd`, `code-review` vid behov | `$implement uppgift 03` |
| `implement-spec` | Orkestrera en godkänd task graph i isolerade worktrees. | Manuell | Spec + uppgifter → integrerad branch | `implement`, `tdd`, `code-review` | `$implement-spec docs/specs/search.md` |
| `tdd` | Driv beteende med red–green–refactor. | Automatisk | Beteende + seam → testad slice | — | `Använd TDD för valideringsregeln.` |
| `diagnosing-bugs` | Fastställ root cause innan fix. | Automatisk | Symptom + miljö → reproduktion och evidens | — | `Diagnostisera den intermittenta timeouten.` |
| `code-review` | Granska diff mot korrekthet, regler och intent. | Automatisk | Fixed point + diff + spec → findings | — | `Granska ändringarna sedan merge base.` |
| `pr` | Skriv evidensbaserad PR-text och riskbedömning. | Automatisk | Diff + observerade checks → PR-utkast | — | `Förbered PR-text för aktuell branch.` |
| `setup-pre-commit` | Lägg till en liten guardrail med befintliga checks. | Manuell | Repo + checks → godkänd hook-konfiguration | — | `$setup-pre-commit använd befintlig formattering` |
| `validate-dotfiles` | Kontrollera dotfiles, toolkit och länkar utan installation. | Automatisk | Dotfiles-repo → valideringsrapport | `just`-recept | `Validera dotfiles efter ändringen.` |

## Agentflöden och lärande

| Skill | Syfte och användning | Läge | Indata → utdata | Beroenden | Exempel |
| --- | --- | --- | --- | --- | --- |
| `handoff` | Bevara verifierat sammanhang över sessionsgräns. | Manuell | Sessionstillstånd → kompakt handoff | — | `$handoff inför nästa session` |
| `writing-for-agents` | Skriv precisa, ekonomiska agentinstruktioner. | Automatisk | Instruktionstext → förbättrad styrning | — | `Granska detta AGENTS.md för no-ops.` |
| `retro` | Härled små miljöförbättringar från genomfört arbete. | Manuell | Sessionsevidens → rangordnade förslag | `writing-for-agents` | `$retro granska den här sessionen` |
| `wizard` | Skapa ett säkert interaktivt flöde för mänskliga steg. | Manuell | Manuell procedur → validerat script | — | `$wizard för CI-secret-konfiguration` |
| `teach` | Lär ut genom förklaring, retrieval och feedback. | Manuell | Lärandemål → adaptiva övningar | — | `$teach förklara async streams` |
| `wait-what` | Förklara senaste resultatet enklare med saknad kontext. | Manuell | Föregående svar → ny förklaring | — | `$wait-what` |

## Skill-hantering

| Skill | Syfte och användning | Läge | Indata → utdata | Beroenden | Exempel |
| --- | --- | --- | --- | --- | --- |
| `setup-project` | Förhandsgranska eller uppdatera förvaltat `AGENTS.md`-block. | Manuell | Projekt + profiler → diff eller applicerad sektion | `scripts/ai-project` | `$setup-project med dotnet-profil` |
| `create-skill` | Logisk ingång för att skapa en repohanterad skill. Implementeras av Codex inbyggda `$skill-creator`, inte en duplicerad lokal skill. | Manuell | Användningsfall → validerad skill | `$skill-creator`, lokala konventioner | `$skill-creator skapa en repohanterad release-skill` |
| `improve-skill` | Förbättra en befintlig repohanterad skill från evidens. | Manuell | Skill + observerat problem → fokuserad ändring | `$skill-creator` | `$improve-skill research triggar för brett` |
| `list-skills` | Inventera skills, ursprung, policy och länkstatus. | Manuell | Miljö → läsbar inventering | `just ai-skills-status` | `$list-skills visa konflikter` |
| `update-skills` | Jämför med upstream och föreslå selektiva förbättringar. | Manuell | Lokala skills + upstream → granskningsförslag | `improve-skill` | `$update-skills jämför med mattpocock/skills` |
| `which-skill` | Rekommendera minsta användbara workflow. | Manuell | Mål → rekommendation och motivering | `list-skills` vid osäkerhet | `$which-skill jag har en svår sporadisk bugg` |
