## 🗺️ Prime Families Roadmap (for primespiral)

This roadmap lists candidate prime families that are currently missing or only partially covered in primespiral, organized by how easy it is to generate candidate numbers in the interval 1:t and then test primality.

The goal is to expand the explorer without breaking its “quick and dirty” visual spirit, while keeping the code readable, heavily commented, and UI-friendly.

https://en.wikipedia.org/wiki/List_of_prime_numbers

---

## 🟡 Level 2 — Medium / Sequence-Driven
Still compatible with the explorer, but often requires prime-index logic,
iterative searches, or careful bounds to keep UI smooth.

- Leyland primes  
  Can be generated with small bounded pairs (x,y) where x^y + y^x <= t.

- Long primes / Full reptend primes (base 10)  
  Requires multiplicative order calculations; reasonable for moderate t.

- Home primes (small range)  
  Iterative factorization-and-concatenation process; keep range-limited.

- Extended Proth/Ramanujan implementations  
  If you decide to scale beyond the current small-range versions.

---

## 🟠 Level 3 — Hard but Worth It (List-Based)
These are rare or computationally expensive.
They fit primespiral best as “list-based families” with honest documentation.

The pattern here is:
use short known lists -> filter <= t -> explain clearly in comments.

- Fortunate primes  
  Computational definition is elegant but quickly becomes UI-hostile due to
  primorial growth and primality testing on huge p# + m values.

- Wilson primes  
- Wieferich primes  
- Wagstaff primes  
- Wolstenholme primes  
- Other similarly rare named families

This approach preserves the educational/visual value without turning the file into
a research-grade number theory library.

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

- Prime clusters / constellations (if added)  
  Definition-choice sensitive and can require heavier pattern management.

- Pi primes  
  More recreational/constant-digit dependent than family-driven.

---

## 🧱 Suggested Milestones

### 🧩 Milestone B (Wikipedia Coverage Boost)
Add computable missing families that still preserve UI smoothness:

- Leyland primes  
- Long primes / Full reptend primes (base 10)  
- Home primes (small range)

Consider adding a tiny internal helper pattern:
generateCandidates_FamilyName(t, pns)
to keep the long switch readable.

### 🧩 Milestone C (Rare Families Pack)
Add list-based families with explicit honesty in comments:

- Fortunate primes  
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
- When a family is list-based, state it explicitly in the case comment.

---

## 🎯 Outcome Goal
After implementing this roadmap, primespiral will include:

- A robust block of formula-based families
- A clean set of sequence/index families
- The classic pair/tuple families already present
- A clearly labeled group of rare list-based families

All while preserving the original aesthetic and “quick and dirty” exploratory spirit.
