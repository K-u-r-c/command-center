# command-center

Pełnoekranowy HUD dla **Hyprlanda** (GTK3 + gtk-layer-shell) w terminalowym, czarno-białym stylu. SUPER+TAB go otwiera, drugie SUPER+TAB albo Esc zamyka.

- **wyszukiwarka aplikacji** w stylu Spotlight (zaczynasz pisać, strzałki wybierają, Enter uruchamia),
- kafelki: **audio** (wyjścia i głośność aplikacji), **jasność** monitorów (DDC/CI) i przełącznik **HDR** (`[T]`, wymaga `hdr.sh` z [hypr](https://github.com/K-u-r-c/hypr)), **Bluetooth**, **zrzuty ekranu**, **tapety**, **system** (CPU, RAM, GPU, VRAM, dysk i liczba aktualizacji przez `checkupdates` + `paru`),
- kafelki da się przeciągać, a układ zapisuje się osobno dla każdej rozdzielczości.

Działa jako demon (`--daemon`), więc otwiera się od razu, bez mignięcia.

> Część zestawu **[linux-tools](https://github.com/K-u-r-c/linux-tools)**: tam jest mapa, co z czym współpracuje, i instalator wszystkiego naraz.

## Instalacja

```bash
# zależności (Arch / CachyOS)
sudo pacman -S --needed python-gobject gtk3 gtk-layer-shell libpulse bluez-utils ffmpeg wl-clipboard xdg-utils
# opcjonalnie: jasność monitorów i licznik aktualizacji
sudo pacman -S --needed ddcutil pacman-contrib && echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf

git clone https://github.com/K-u-r-c/command-center ~/.local/share/command-center
mkdir -p ~/.local/bin
ln -sfn ~/.local/share/command-center/command_center.py ~/.local/bin/command-center
ln -sfn ~/.local/share/command-center/cc-restart.sh     ~/.local/bin/command-center-restart
```

W `~/.config/hypr/hyprland.conf`:

```ini
exec-once = ~/.local/bin/command-center --daemon
bind = SUPER, TAB, exec, ~/.local/bin/command-center
bind = SUPER SHIFT, TAB, exec, ~/.local/bin/command-center-restart   # restart demona (po aktualizacji / gdy się zawiesi)
```

Albo całość jednym poleceniem przez [linux-tools](https://github.com/K-u-r-c/linux-tools): `./install.sh command-center`.

## Aktualizacja

```bash
git -C ~/.local/share/command-center pull && ~/.local/bin/command-center-restart
```

## Współpraca z innymi narzędziami

| Z czym | Po co | Bez tego |
|---|---|---|
| [hypr](https://github.com/K-u-r-c/hypr): `~/.config/hypr/wallpaper.sh` | kafelek tapet ustawia tapety (obrazy przez hyprpaper, wideo przez mpvpaper) | kafelek tylko listuje pliki z `~/Pictures/wallpapers` |
| [hypr](https://github.com/K-u-r-c/hypr): `monitors.conf` (`env = PRIMARY_MONITOR,…`) | który monitor jest główny | główny = największy |
| [wall-downloader](https://github.com/K-u-r-c/wall-downloader) | pobiera animowane tapety do `~/Pictures/wallpapers` (prefiks `uw-` dla 21:9) razem z miniaturami w `~/.cache/wallpaper-thumbs` | — |
| [alacritty](https://github.com/K-u-r-c/alacritty) | terminal do aktualizacji (`paru`) i aplikacji terminalowych | inny terminal przez `$TERMINAL` |

## Pliki

| Ścieżka | Co |
|---|---|
| `~/.config/command-center/layout.json` | położenie kafelków (per rozdzielczość) |
| `~/.cache/command-center-*.json` | cache: aktualizacje, użycie aplikacji, monitory DDC |
| `~/.cache/wallpaper-thumbs/`, `~/.cache/screenshot-thumbs/` | miniatury (wspólne z `wallpaper.sh` i wall-downloaderem) |
