# decouple-bench — whitepaper

Source for the figures (and, later, the paper) that describe how
`jsp-decouple-bench` runs a measurement: what a run touches, what it is
kept away from, and what is kept of it afterwards.

This repository is graphics only for now.

## Figures

| file | what it claims |
|---|---|
| `01-two-phases` | a run is two evals — a solve inside Inspect's sandbox, a score on the host — and the only thing that crosses is the tree |
| `02-agent-boundary` | the sandbox has the tree and a database sidecar, and no path to the bench, the goldens or the docker socket |
| `03-workspace-provenance` | the workspace is an extracted archive committed once, not a clone: no history, no refs, no reflog; what comes back is that tree plus one diff |
| `04-case-isolation` | one case, one compose project, an empty database, and `down -v` before the next |
| `05-escape-paths` | five ways out of the solve sandbox, by cost: host git on the agent's `.git/`, the public repo over open egress, root through the bind mount, a runtime escape, the agent's code at scoring time |
| `06-context-leaks` | what a shell inside the workspace can read: what names the measurement, what carries the answer, and what holds |

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
page per figure for review, the threat model behind figures 5 and 6, where
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
