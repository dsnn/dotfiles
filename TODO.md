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
| Installationslucka | htop | Konfigurationen finns och bootstrap länkar den, men `htop` är inte installerat och saknas i `Brewfile`. Själva filen bör därefter genereras med aktuell htop-version. |
| Låg | inputrc | Fungerar, men påverkar inte Zsh—bara Readline-program som Bash. Kan kompletteras om dessa används. |
| Låg | Starship | Giltig och fungerande. Paletten är betydligt större än vad prompten använder och formatet kan förenklas, men inga riktiga fel hittades. |
| Mycket låg | bat | Fungerar. Catppuccin Mocha ingår redan i bat 0.26.1, så den separata temafilen och symlänken är numera överflödiga. |

Rekommenderad arbetsordning: Zsh → tmux → Neovim → SSH → Git → lazygit → lsd → IdeaVim → resten.
