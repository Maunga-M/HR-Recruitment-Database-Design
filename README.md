# HR Recruitment Database

A relational database designed from scratch to support hiring process analysis at a growing tech company.

The database captures the full recruitment lifecycle from job openings and candidate applications through interviews, offers, and final decisions, in enough detail to answer four core business questions:

- Which stage of the recruitment process takes the longest?
- Which hiring managers or teams are contributing to delays?
- Which sourcing channels produce the best outcomes?
- Why are candidates dropping out, and at what stage?

## Files

| File | Description |
|---|---|
| `schema.sql` | SQL DDL scripts for all 14 tables |
| `schema.png` | Entity relationship diagram |
| `README.md` | This file |

## Schema

The interactive schema diagram is available on dbdiagram.io: https://dbdiagram.io/d/Recruitment-69c198fd78c6c4bc7a4c08e0

The schema contains 14 tables organised around the recruitment process. Key design decisions include:

- A stage events log that records every transition between recruitment stages, enabling time-in-stage analysis
- A junction table for panel interviews so each participant can submit individual feedback
- Separate exit reason tables for mid-process drop-offs and offer declines, since these represent different problems
- Source tracking at both the candidate and application level to measure which channels drive actual hires

## Tools

SQL (MySQL compatible)
