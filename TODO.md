# Dotfiles TODO

Alla konfigurationer är syntaktiskt giltiga, men följande förbättringar har identifierats.

| Prioritet | Konfiguration | Faktiska förbättringar |
|---|---|---|
| Klar | ~~Zsh~~ | Åtgärdat: minimal `.zshenv`, portabel `.zprofile`, defensiv plugin-laddning, säkrare historik/completion-cache, portabla verktygssökvägar och reparerade funktioner/alias. |
| Klar | ~~tmux~~ | Åtgärdat: korrekt `tmux-256color` och moderna terminal features, fokus och clipboard, fungerande statusuppdatering, Catppuccin v2-konfiguration, säkrare binds, en enda sesh-launcher samt reproducerbar TPM-installation och syntaxkontroll. |
| Klar | ~~Neovim~~ | Åtgärdat: Treesitter `main` och dess nya Neovim 0.12-API, reproducerbara parserberoenden och bevarad incremental selection, `lazydev` i stället för EOL `neodev`, Mason-hanterade LSP-servrar, robusta `LspAttach`-mappings samt aktiverad swap och persistent undo. |
| Klar | ~~lazygit~~ | Åtgärdat: konfigurationen använder de aktuella `diffRenderers`/`command`-nycklarna; Linux- och GNU-specifika override-kommandon är borttagna så lazygit använder sina inbyggda plattformsdefaults för filöppning och systemclipboard; officiell schemahint och Catppuccin Mocha med mauve-accent är tillagda. |
| Klar | ~~lsd~~ | Åtgärdat: tidsformatet använder nu `%M` för minuter och visar korrekt `%H:%M:%S`. |
| Klar | ~~SSH~~ | Åtgärdat: includes använder `~`, GitHub har ett värdspecifikt och strikt nyckelval, generiska värdar tillåter åter sina egna autentiseringsmetoder och onödig global komprimering är borttagen. Bootstrap skapar och säkrar båda SSH-katalogerna. |
| Klar | ~~Git~~ | Åtgärdat: Git Credential Manager anropas med det portabla helper-namnet, global `useHttpPath` och ignore av `nuget.config` är borttagna, och Delta har en enda sammanhållen Catppuccin Mocha-konfiguration. |
| Klar | ~~IdeaVim~~ | Åtgärdat: IDE-actions använder modern `<Action>(…)`-syntax och modspecifika mappings, Which-key-beskrivningarna är unika och korrekta, LSP-navigationen matchar Neovim och nya genvägar täcker diagnostics, VCS-hunks, filhistorik, blame, imports, inline-refaktorering, projektfönster och terminal. |
| Klar | ~~htop~~ | Åtgärdat: htop 3.5.3 är installerat och deklarerat i `Brewfile`; den befintliga layouten är verifierad mot aktuell parser och versionsmarkören är uppdaterad utan att användarens mätare, kolumner eller sortering skrivits över. |
| Klar | ~~inputrc~~ | Åtgärdat: filens Readline-scope är dokumenterat, terminalklockan är avstängd och upp/ned söker nu historik efter redan inskrivet kommandoprefix. Konfigurationen verifieras via Bash i `just check`. |
| Klar | ~~Starship~~ | Åtgärdat: formatet är förenklat, Git-statusens style appliceras korrekt, Catppuccin-paletten innehåller bara använda färger och officiell schemahint samt runtime-kontroll är tillagda. |
| Klar | ~~bat~~ | Åtgärdat: den redundanta Catppuccin-filen och bootstrap-symlänken är borttagna; bat använder sitt inbyggda Catppuccin Mocha och städar den tidigare hanterade symlänken säkert. |

Alla granskade konfigurationer är nu åtgärdade.
