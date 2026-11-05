# decouple-bench — whitepaper

Source for the figures (and, later, the paper) that describe how
`jsp-decouple-bench` runs a measurement: what a run touches, what it is
kept away from, and what is kept of it afterwards.

This repository is graphics only for now.

## Figures

| file | what it claims |
|---|---|
| `01-two-phases` | a run is two evals on one host — solves in Inspect sandboxes, scores in one stack per case, each side by side — and the only thing that crosses is the tree, as host files |
| `02-case-isolation` | one case, one compose project on its own free port, an empty database, `down -v` after; cases side by side, up to a host-wide cap |

Each figure is a file that names the sources it was drawn from, so a
claim can be checked against the code rather than believed.

## Build

Needs `xelatex` with TikZ, `fontspec`, `fontawesome5`, `enumitem` and
`multicol` (`texlive-xetex`, `texlive-pictures`, `texlive-fonts-extra`).
The type follows `DESIGN.md` — Quicksand, Hanken Grotesk, JetBrains Mono —
and ships in `src/graphics/fonts/` (all SIL OFL), so a build depends on no
system font.

```bash
make          # every figure, then the atlas
make png      # the same again, plus PNG previews
make clean
```

Output lands in `build/`: one PDF per figure, plus `atlas.pdf`, a landscape
page per figure for review, the threat model behind them, where
the harness sits in the literature, and IEEE references.

## Layout

```
src/graphics/
  style.tex            the palette, the type, the icons, the shapes — one place
  fonts/               the three families DESIGN.md names (OFL)
  atlas.tex            every figure with its heading, for review
  figures/NN-*.tex     one standalone document per figure
```

A figure compiles on its own (`cd src/graphics && xelatex figures/01-two-phases.tex`),
so it can be dropped into the paper unchanged.

Two conventions worth keeping: no meaning is carried by colour alone (the
figures must survive grayscale), and no figure invents a style that
`style.tex` does not define.
