## 🗺️ Prime Families Roadmap (for primespiral)

This roadmap lists candidate prime families that are currently missing or only partially covered in primespiral, organized by how easy it is to generate candidate numbers in the interval 1:t and then test primality.

The goal is to expand the explorer without breaking its “quick and dirty” visual spirit, while keeping the code readable, heavily commented, and UI-friendly.

https://en.wikipedia.org/wiki/List_of_prime_numbers

---

## 🟢 Level 1 — Easy / Formula-Based
These families are ideal for primespiral because they follow the pattern:
generate formula candidates -> keep <= t -> isprime.

They are fast, short to implement, and great for interactive visualization.

- Ramanujan primes (small-range implementation)  
  Defined via prime-counting properties; implement only for small n values supported by t.

---

## 🟡 Level 2 — Medium / Sequence-Driven
Still compatible with the explorer, but often requires prime-index logic,
iterative searches, or careful bounds to keep UI smooth.

- Fortunate primes (range-limited)  
  Based on primorials p# and the smallest m > 1 such that p# + m is prime.
  Needs careful handling because outputs can exceed t.

- Extended Proth/Ramanujan implementations  
  If you decide to scale beyond small-range versions.

---

## 🟠 Level 3 — Hard but Worth It (List-Based)
These are rare or computationally expensive.
They fit primespiral best as “list-based families” with honest documentation.

The pattern here is:
use short known lists -> filter <= t -> explain clearly in comments.

- Wilson primes  
- Wieferich primes  
- Wagstaff primes  
- Wolstenholme primes  
- Other similarly rare named families

This approach preserves the educational/visual value without turning the file into a research-grade number theory library.

---

## 🔴 Level 4 — Defer / High-Theory or Heavy Computation
These are not forbidden, but they are likely to distort the lightweight
nature of primespiral unless implemented as very small-range lists.

- Irregular primes / Regular primes  
  Bernoulli-number dependent families.

- Mills primes  
  Depends on a constant not practical for quick generation.

- Highly cototient primes  
  Heavy arithmetic-function machinery.

- Harmonic primes  
  Definitions and usage can be less standardized.

- Permutable primes  
  Can be combinatorially expensive.

- Pi primes  
  More recreational/constant-digit dependent than family-driven.

---

## 🧱 Suggested Milestones

### 🧩 Milestone B (Moderate Expansion)
Add families that need careful bounding:

- Ramanujan primes (extended but still range-limited)  
- Fortunate primes

Consider adding a tiny internal helper pattern:
generateCandidates_FamilyName(t, pns)
to keep the long switch readable.

---

### 🧩 Milestone C (Rare Families Pack)
Add list-based families with explicit honesty in comments:

- Wilson primes  
- Wieferich primes  
- Wagstaff primes  
- Wolstenholme primes

---

## 🧠 Style and Maintenance Notes
- Keep the interactive default behavior intact.
- Parametric mode should behave consistently when Spiral/Family are provided.
- Text descriptions must be explicit plain English (or plain text) definitions.
- The code should remain heavily commented, family by family.
- The function should remain smooth and readable for typical t values used in exploration.

---

## 🎯 Outcome Goal
After implementing this roadmap, primespiral will include:

- A robust block of formula-based families
- A clean set of sequence/index families
- The classic pair/tuple families already present
- A clearly labeled group of rare list-based families

All while preserving the original aesthetic and “quick and dirty” exploratory spirit.
