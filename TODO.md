# Dotfiles TODO

Alla konfigurationer är syntaktiskt giltiga, men följande förbättringar har identifierats.

| Prioritet | Konfiguration | Faktiska förbättringar |
|---|---|---|
| Hög | Zsh | Skriver över `TERM`, har hårdkodade Homebrew- och användarsökvägar, kan ge startfel på Linux, saknar eller dubbelladdar plugins, innehåller skrivfelet `bunzip3` och har ett par trasiga alias. |
| Hög | tmux | Bör använda `tmux-256color`; `focus-events` är avstängt; flera Catppuccin-inställningar är gamla eller felstavade; `status-interval 0` stänger av uppdateringar. |
| Hög | Neovim | Installerade Neovim 0.12 stöds inte av vald Treesitter-branch, som dessutom är fryst och felaktigt lazy-loadad. `neodev` är EOL, flera aktiverade LSP-servrar saknas och både swap samt persistent undo är avstängda. |
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
