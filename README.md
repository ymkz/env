# dotfiles

## Installation

```sh
curl -sSfL https://raw.githubusercontent.com/ymkz/dotfiles/HEAD/boot/run.sh | bash
```

## Applications

### WSL

- [Google Chrome](https://www.google.com/intl/ja_jp/chrome)
- [Google Japanese IME](https://www.google.co.jp/ime)
- [Visual Studio Code](https://code.visualstudio.com)
- [ShareX](https://apps.microsoft.com/store/detail/sharex/9NBLGGH4Z1SP)
- [QuickLook](https://apps.microsoft.com/store/detail/quicklook/9NV4BS3L1H4S)

## Notes

zsh について`zsh/.zshenv`だけが`$HOME`直下に配置される。  
このファイルの`$ZDOTDIR`の指定により、`.zshrc`などは`$ZDOTDIR`配下から読み込まれる。
