---
type: project
topic: infrastructure naming conventions
created: 2026-04-29
originSessionId: e1dbcb07-8228-4619-b6cb-9e85ff30db06
---
# Infrastructure Naming Conventions

## Suffix range for test/development machines

Each machine class reserves the **90–99 suffix range** for test/development machines. Production machines use the remaining range (00/01 through 89).

## Defined classes

| Class | Description | Production range | Test range |
|---|---|---|---|
| artemis | Linux desktop workstations | artemis01–artemis89 | artemis90–artemis99 |
| boros | Linux laptop workstations | boros01–boros89 | boros90–boros99 |
| vedfolnir | Desktop inference nodes | vedfolnir00–vedfolnir89 | vedfolnir90–vedfolnir99 |

## Notes

- **vedfolnir** starts at `00` (not `01`), unlike artemis and boros which start at `01`. The test suffix pattern (`xx90`–`xx99`) is consistent across all classes regardless of where production numbering starts.
