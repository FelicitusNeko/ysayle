# Ysayle Gentoo Repository

To add as an overlay (easy method):
- Install `eselect-repository`
- Run `eselect repository add ysayle git https://github.com/FelicitusNeko/ysayle.git`
- Sync

## Wish list

- Missing packages ­— as far as I know, these don't exist on any repo
  - Bizhawk
  - Chatty (Twitch chat client)
  - F-Chat Horizon
    - ebuild exists, but is outdated
  - Fightcade
  - Imageboard Grabber
    - uses Node in its build environment
  - OpenDeck
    - uses Deno in its build environment
  - Ruffle nightly
  - XIVLauncher.Core RankynBass fork
  - ZQuest Classic
    - Breaks both network and filesystem sandboxes to build
- Packages to improve
  - `games-util/poptracker`
    - Not keyworded because it uses `git-r3.eclass`, necessary due to submodules

*"I am neither a saint nor a savior - just another sinner. Yet I will not forsake this cause. I cannot. I will see this cycle broken and peace restored."*
