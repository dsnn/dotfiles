# Dotfiles TODO

Alla konfigurationer är syntaktiskt giltiga, men följande förbättringar har identifierats.

| Prioritet | Konfiguration | Faktiska förbättringar |
|---|---|---|
| Klar | ~~Zsh~~ | Åtgärdat: minimal `.zshenv`, portabel `.zprofile`, defensiv plugin-laddning, säkrare historik/completion-cache, portabla verktygssökvägar och reparerade funktioner/alias. |
| Klar | ~~tmux~~ | Åtgärdat: korrekt `tmux-256color` och moderna terminal features, fokus och clipboard, fungerande statusuppdatering, Catppuccin v2-konfiguration, säkrare binds, en enda sesh-launcher samt reproducerbar TPM-installation och syntaxkontroll. |
| Klar | ~~Neovim~~ | Åtgärdat: Treesitter `main` och dess nya Neovim 0.12-API, reproducerbara parserberoenden och bevarad incremental selection, `lazydev` i stället för EOL `neodev`, Mason-hanterade LSP-servrar, robusta `LspAttach`-mappings samt aktiverad swap och persistent undo. |
| Hög | lazygit | Använder `xdg-open`, som inte finns på macOS-installationen. Öppna-fil-funktionen fungerar därför inte. Clipboard-kommandot kan också göras enklare och mer portabelt. |
| Hög, liten fix | lsd | Tidsformatet använder `%m` för minuter; `%m` betyder månad. Det ska vara `%H:%M:%S`. |
| Medel | SSH | Två absoluta `/Users/dsn`-includes gör filen icke-portabel. Globala `IdentitiesOnly` och `PreferredAuthentications publickey` kan dessutom blockera legitima värdar och MFA-inloggningar. |
| Medel | Git | Credential-helpern har en hårdkodad sökväg, `useHttpPath` gäller onödigt globalt, Delta har dubblerade inställningar och global ignore av `nuget.config` kan dölja filer som borde committas. |
| Medel | IdeaVim | Which-key-beskrivningar kolliderar eller stämmer inte med mappings, `<leader>gu` definieras dubbelt och många rekursiva `map` bör bli modspecifika `nnoremap`/`vnoremap`. |
| Installationslucka | htop | Konfigurationen finns och bootstrap länkar den, men `htop` är inte installerat och saknas i `Brewfile`. Själva filen bör därefter genereras med aktuell htop-version. |
| Låg | inputrc | Fungerar, men påverkar inte Zsh—bara Readline-program som Bash. Kan kompletteras om dessa används. |
| Låg | Starship | Giltig och fungerande. Paletten är betydligt större än vad prompten använder och formatet kan förenklas, men inga riktiga fel hittades. |
| Mycket låg | bat | Fungerar. Catppuccin Mocha ingår redan i bat 0.26.1, så den separata temafilen och symlänken är numera överflödiga. |

Rekommenderad arbetsordning: Zsh → tmux → Neovim → SSH → Git → lazygit → lsd → IdeaVim → resten.
